import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello world !'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connectez-vous',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: true, // Pour masquer le mot de passe
                decoration: InputDecoration(
                  labelText: 'Submit',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique de connexion
              },
              child: Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
