import 'package:flutter/material.dart';
import '../blocs/coingecko_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            await bloc.bSigninWithGoogle(context);
          },
          child: const Text(
            "Signin with Google",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
