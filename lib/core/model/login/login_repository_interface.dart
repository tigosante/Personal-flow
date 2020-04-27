import 'package:firebase_auth/firebase_auth.dart';

abstract class ILoginRepository {
  Future<FirebaseUser> getGoogleLogin();
  Future<FirebaseUser> getUser();
  Future getLogOut();
}
