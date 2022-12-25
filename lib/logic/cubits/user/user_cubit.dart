import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftickets/data/repositories/user_repository.dart';
import 'package:nftickets/utils/constants.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'user_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nftickets/data/models/user_model.dart' as model;

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial()) {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      signIn(firebaseUser.email ?? firebaseUser.phoneNumber);
    } else {
      emit(UserLogOutSuccess());
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  final _userRepository = UserRepository();
  var _success;

  void sendOTP(String phoneNumber) async {
    emit(UserLoadInProgress());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _success = false;
        _verificationId = verificationId;
        emit(UserSendCodeSuccess());
      },
      verificationCompleted: (phoneAuthCredential) {
        //signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(UserIsFailure(ktryLater));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (!_success) {
          emit(UserIsFailure(ktimeOut));
        }
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(UserLoadInProgress());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    _success = true;
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          final user = model.User(id: userCredential.user!.phoneNumber!);
          signUp(user);
        } else {
          signIn(userCredential.user!.phoneNumber!);
        }
      }
    } on FirebaseAuthException catch (ex) {
      developer.log(ex.toString(), name: 'Catch Phone sign in');
      emit(UserTypeCodeFailure());
    }
  }

  Future signInWithGoogle() async {
    emit(UserLoadInProgress());
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(UserIsFailure(ktryLater));
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      signInWithCredential(credential);
    } catch (e) {
      developer.log(e.toString(), name: 'Catch Google sign in');
      emit(UserIsFailure(kbadRequest));
    }
  }

  Future signInWithApple() async {
    emit(UserLoadInProgress());
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
      emit(UserIsFailure(kbadRequest));
    }
  }

  Future<void> signInWithCredential(credential) async {
    try {
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.additionalUserInfo!.isNewUser) {
        final user = model.User(
            id: authResult.user!.email!,
            fullName: authResult.user!.displayName,
            image: authResult.user!.photoURL);
        signUp(user);
      } else {
        signIn(authResult.user!.email!);
      }
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign in with credential');
      emit(UserIsFailure(kbadRequest));
    }
  }

  Future<void> signUp(model.User user) async {
    try {
      final result = await _userRepository.signUp(user);
      result != null
          ? emit(UserLogInSuccess(user))
          : emit(UserIsFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign up');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> signIn(String? id) async {
    try {
      final result = await _userRepository.signIn(id);
      result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign in');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }

  void signOut() async {
    //if (_auth.currentUser?.email != null) await GoogleSignIn().disconnect();
    await _auth.signOut().then((value) => emit(UserLogOutSuccess()));
  }
}
