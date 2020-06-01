import 'package:firebase_auth/firebase_auth.dart';

abstract class DefaultInterface {
  Future<FirebaseUser> getUser();
  Future getLogOut();
}
