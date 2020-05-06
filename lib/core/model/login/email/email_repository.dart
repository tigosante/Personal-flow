import 'package:firebase_auth/firebase_auth.dart';
import 'package:personalflow/core/model/login/email/email_interface.dart';

class LoginEmailRepository implements EmailInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> getUser() => _auth.currentUser();

  @override
  Future getLogOut() async => await _auth.signOut();
  Future<FirebaseUser> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<FirebaseUser> getEmailLogin() async => await _auth.currentUser();

  Future<void> signOut() async => _auth.signOut();

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }
}
