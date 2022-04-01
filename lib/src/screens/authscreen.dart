import 'package:flutter/material.dart';
import '../utils/authentication.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Authentication.signInWithGoogle(context: context);
          },
          child: Container(
            color: Colors.black,
            child: const Text(
              "Signin with Google",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
