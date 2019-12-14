import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_flow/view/login/login.dart';
import 'package:personal_flow/view/novaTarefa/novaTarefa.dart';
import 'package:personal_flow/view/telas.dart';

final GoogleSignIn _usuarioGoogle   = GoogleSignIn();
final FirebaseAuth _usuarioFireBase = FirebaseAuth.instance;
GoogleSignInAccount _usuarioAtual = _usuarioGoogle.currentUser;

Future _autenticarLogins() async {
  if (_usuarioAtual == null)
    _usuarioAtual = await _usuarioGoogle.signInSilently();
    
  if (_usuarioAtual == null)
    _usuarioAtual = await _usuarioGoogle.signIn();

  final GoogleSignInAuthentication googleAuth = 
      await _usuarioAtual.authentication;

  if (await _usuarioFireBase.currentUser() == null) {
    await _usuarioFireBase
        .signInWithCredential(GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken    : googleAuth.idToken,
    ));
  }
}

bool usuarioLogado(){
  return _usuarioGoogle.currentUser == null;
}

void main()=> runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home                      : !usuarioLogado() ? Login() : Telas(),
      title                     : "Personal Flow",
      color                     : Colors.teal,
      debugShowCheckedModeBanner: false,
      themeMode                 : ThemeMode.system,

      darkTheme                 : ThemeData(
        brightness      : Brightness.dark,
        splashColor     : Colors.black,
        primaryColor    : Colors.teal,
        primaryColorDark: Colors.teal,
      ),

      theme: ThemeData(
        brightness      : Brightness.light,
        splashColor     : Colors.white,
        primaryColor    : Colors.teal,
        primaryColorDark: Colors.teal,
      ),
    );
  }
}
