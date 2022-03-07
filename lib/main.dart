import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<UserCredential> signIn() async {
      final LoginResult login = await FacebookAuth.instance.login();
      final OAuthCredential face =
          FacebookAuthProvider.credential(login.accessToken!.token);

      Navigator.push(context, MaterialPageRoute(builder: (_) => Logged()));

      return FirebaseAuth.instance.signInWithCredential(face);
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              signIn();
            },
            child: Text('Facebook Login')),
      ),
    );
  }
}

class Logged extends StatelessWidget {
  const Logged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Logged In', style: TextStyle(fontSize: 54)),
      ),
    );
  }
}
