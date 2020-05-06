import 'package:firebase_auth/firebase_auth.dart';
import 'package:personalflow/core/model/login/default_interface.dart';

abstract class EmailInterface implements DefaultInterface {
  Future<FirebaseUser> getEmailLogin();

  Future<bool> isEmailVerified();
  Future<void> sendEmailVerification();

  Future<FirebaseUser> signIn(String email, String password);
  Future<FirebaseUser> signUp(String email, String password);
}
