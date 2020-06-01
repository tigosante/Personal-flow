import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personalflow/core/interfaces/google_interface.dart';

class LoginGoogleRepository implements GoogleInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<FirebaseUser> getGoogleLogin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  @override
  Future<FirebaseUser> getUser() => _auth.currentUser();

  @override
  Future getLogOut() async => await _auth.signOut();
}
