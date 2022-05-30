import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/blocs/theme_provider.dart';
import 'package:coingecko/src/model/themes.dart';
import 'package:coingecko/src/screens/authscreen.dart';
import 'package:coingecko/src/screens/cypto_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import './src/utils/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BusyHandler()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (ctx, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Crypto App',
              theme: value.getTheme(),
              home: GoogleSignIn().currentUser == null &&
                      FirebaseAuth.instance.currentUser == null
                  ? const AuthScreen()
                  : const CryptoList(),
            );
          },
        ));
  }
}
