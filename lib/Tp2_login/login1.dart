import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:todolist_app/tasks.dart';
import 'package:todolist_app/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login1Page(),
      theme: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class Login1Page extends StatefulWidget {
  @override
  _Login1PageState createState() => _Login1PageState();
}

class _Login1PageState extends State<Login1Page> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> authenticateWithEmail() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      User? user = userCredential.user;
      setState(() {
        message = 'Connexion réussie';
      });
      // Rediriger vers la page "Tasks" après la connexion réussie
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Tasks()),
      );
    } catch (e) {
      setState(() {
        message = 'Échec d\'authentification : $e';
      });
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    setState(() {
      message = 'Connexion avec Google réussie';
    });
    // Rediriger vers la page "Tasks" après la connexion réussie
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Tasks()),
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> authenticateWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = userCredential.user;
        setState(() {
          message = 'Connexion Facebook réussie';
        });
        // Rediriger vers la page "Tasks" après la connexion réussie
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tasks()),
        );
      } else {
        setState(() {
          message = 'Échec de la connexion Facebook : ${result.message}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Échec de la connexion Facebook : $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: Colors.black),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              onPressed: () {
                authenticateWithEmail();
              },
              child: Text('Connexion par e-mail', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.g_translate),
                  SizedBox(width: 10),
                  Text('Connexion avec Google', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () {
                authenticateWithFacebook();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook),
                  SizedBox(width: 10),
                  Text('Connexion avec Facebook', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(message, style: TextStyle(color: Colors.black)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text(
                'Pas encore inscrit ? Créez un compte',
                style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}