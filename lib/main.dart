import 'package:coingecko/src/screens/authscreen.dart';
import 'package:coingecko/src/screens/cypto_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './src/utils/authentication.dart';

void main() async{
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
      debugShowCheckedModeBanner: false,
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GoogleSignIn().currentUser == null ? const AuthScreen() : const CryptoList(),
    );
  }
}

