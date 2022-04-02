import 'package:flutter/material.dart';
import '../blocs/coingecko_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 40,
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/search.png",
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 5,),
              TextButton(
                onPressed: () async {
                  await bloc.bSigninWithGoogle(context);
                },
                child: const Text(
                  "Signin with Google",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
