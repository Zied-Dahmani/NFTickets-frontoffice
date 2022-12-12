import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftickets/data/repositories/auth_repository.dart';
import 'package:nftickets/utils/constants.dart';
import 'auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nftickets/data/models/user_model.dart' as Model;

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  final authRepository = AuthRepository();

  AuthCubit() : super(AuthInitialState()) {
    dynamic currentUser = _auth.currentUser;
    if (currentUser != null) {
      //emit(AuthLoggedInState(currentUser));
    } else {
      emit(AuthLoggedOutState());
    }
  }

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        //signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthCodeNotSentErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          //emit(AuthLoggedInState(authResult.user!));
        } else {
         // authRepository.signIn();
          //emit(AuthLoggedInState(authResult.user!));
        }
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthCodeIncorrectErrorState(ex.message.toString()));
    }
  }

  Future googleSignIn() async {
    emit(AuthLoadingState());
    final googleSignIn = GoogleSignIn();

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.additionalUserInfo!.isNewUser) {
        final user = Model.User(
            id: authResult.user!.email,
            fullName: authResult.user!.displayName,
            followers: [],
            following: []);
        dynamic result = await authRepository.signUp(user);
        result != null
            ? emit(AuthLoggedInState(user))
            : emit(AuthErrorState(kbadRequest));
      } else {
        final result = await authRepository.signIn(authResult.user!.email);
        result != null
            ? emit(AuthLoggedInState(Model.User.fromJson(result)))
            : emit(AuthErrorState(kbadRequest));      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  void signOut() async {
    if (_auth.currentUser?.email != null) await GoogleSignIn().disconnect();
    await _auth.signOut().then((value) => emit(AuthLoggedOutState()));
  }
}
