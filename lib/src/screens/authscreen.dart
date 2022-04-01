import 'package:coingecko/src/screens/cypto_list_screen.dart';
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
            Authentication.signInWithGoogle(context: context).whenComplete((){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return const CryptoList();
                })
              );
            });
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
