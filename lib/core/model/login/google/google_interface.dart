import 'package:firebase_auth/firebase_auth.dart';
import 'package:personalflow/core/model/login/default_interface.dart';

abstract class GoogleInterface implements DefaultInterface {
  Future<FirebaseUser> getGoogleLogin();
}
