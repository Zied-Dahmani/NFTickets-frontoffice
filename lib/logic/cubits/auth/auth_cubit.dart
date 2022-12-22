import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftickets/data/repositories/auth_repository.dart';
import 'package:nftickets/utils/constants.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nftickets/data/models/user_model.dart' as Model;

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  final authRepository = AuthRepository();
  var success;

  AuthCubit() : super(AuthInitial()) {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      signIn(firebaseUser.email ?? firebaseUser.phoneNumber);
    } else {
      emit(AuthLogOutSuccess());
    }
  }

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadInProgress());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        success = false;
        _verificationId = verificationId;
        emit(AuthSendCodeSuccess());
      },
      verificationCompleted: (phoneAuthCredential) {
        //signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthIsFailure(ktryLater));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (!success) {
          emit(AuthIsFailure(ktimeOut));
        }
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadInProgress());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    success = true;
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          final user = Model.User(id: userCredential.user!.phoneNumber!);
          signUp(user);
        } else {
          signIn(userCredential.user!.phoneNumber!);
        }
      }
    } on FirebaseAuthException catch (ex) {
      developer.log(ex.toString(), name: 'Catch Phone sign in');
      emit(AuthTypeCodeFailure());
    }
  }

  Future signInWithGoogle() async {
    emit(AuthLoadInProgress());
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthIsFailure(ktryLater));
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      signInWithCredential(credential);
    } catch (e) {
      developer.log(e.toString(), name: 'Catch Google sign in');
      emit(AuthIsFailure(kbadRequest));
    }
  }

  Future signInWithApple() async {
    emit(AuthLoadInProgress());
    try {
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
          idToken: appleIdCredential.identityToken!,
          accessToken: appleIdCredential.authorizationCode);
      signInWithCredential(credential);
    } catch (e) {
      developer.log(e.toString(), name: 'Catch Apple sign in');
      emit(AuthIsFailure(kbadRequest));
    }
  }

  Future<void> signInWithCredential(credential) async {
    try {
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.additionalUserInfo!.isNewUser) {
        final user = Model.User(
            id: authResult.user!.email!,
            fullName: authResult.user!.displayName,
            image: authResult.user!.photoURL);
        signUp(user);
      } else {
        signIn(authResult.user!.email!);
      }
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign in with credential');
      emit(AuthIsFailure(kbadRequest));
    }
  }

  Future<void> signUp(Model.User user) async {
    try {
      final result = await authRepository.signUp(user);
      result != null
          ? emit(AuthLogInSuccess(user))
          : emit(AuthIsFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign up');
      emit(AuthIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> signIn(String? id) async {
    try {
      final result = await authRepository.signIn(id);
      result != null
          ? emit(AuthLogInSuccess(Model.User.fromJson(result)))
          : emit(AuthIsFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign in');
      emit(AuthIsFailure(kcheckInternetConnection));
    }
  }

  void signOut() async {
    //if (_auth.currentUser?.email != null) await GoogleSignIn().disconnect();
    await _auth.signOut().then((value) => emit(AuthLogOutSuccess()));
  }
}
