import 'dart:developer' as developer;
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

  AuthCubit() : super(AuthInitial()) {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      signIn(firebaseUser.email ?? firebaseUser.phoneNumber);
    } else {
      emit(AuthLoggedOut());
    }
  }

  void sendOTP(String phoneNumber) async {
    emit(AuthLoading());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSent());
      },
      verificationCompleted: (phoneAuthCredential) {
        //signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthError(ktryLater));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        emit(AuthError(ktimeOut));
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(AuthLoading());
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
          final user = Model.User(
              id: userCredential.user!.phoneNumber,
              fullName: '',
              followers: [],
              following: []);
          signUp(user);
        } else {
          signIn(userCredential.user!.phoneNumber);
        }
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthCodeIncorrectError(ex.message.toString()));
    }
  }

  Future googleSignIn() async {
    emit(AuthLoading());
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthError(ktryLater));
        return;
      }

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
        signUp(user);
      } else {
        signIn(authResult.user!.email);
      }
    } catch (e) {
      developer.log(e.toString(), name: 'Catch Google sign in');
      emit(AuthError(kbadRequest));
    }
  }

  Future<void> signUp(Model.User user) async {
    try {
      final result = await authRepository.signUp(user);
      result != null
          ? emit(AuthLoggedIn(user))
          : emit(AuthError(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign up');
      emit(AuthError(kcheckInternetConnection));
    }
  }

  Future<void> signIn(String? id) async {
    try {
      final result = await authRepository.signIn(id);
      result != null
          ? emit(AuthLoggedIn(Model.User.fromJson(result)))
          : emit(AuthError(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign in');
      emit(AuthError(kcheckInternetConnection));
    }
  }

  void signOut() async {
    if (_auth.currentUser?.email != null) await GoogleSignIn().disconnect();
    await _auth.signOut().then((value) => emit(AuthLoggedOut()));
  }
}
