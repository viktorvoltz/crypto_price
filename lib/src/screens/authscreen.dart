import 'package:flutter/material.dart';
import '../blocs/coingecko_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.black,
          child: TextButton(
            onPressed: () async{
              await bloc.bSigninWithGoogle(context);
            },
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
