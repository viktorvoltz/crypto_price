
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/cypto_list_screen.dart';
import 'package:coingecko/src/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BusyHandler extends ChangeNotifier{
  User? _user;
  bool _isbusy = false;

  bool get isbusy => _isbusy;



  Future<void> bSigninWithGoogle(BuildContext context) async {
    _isbusy = true;
    notifyListeners();
    _user = await Authentication.signInWithGoogle(context: context).whenComplete(() {
      _isbusy = false;
      notifyListeners();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const CryptoList();
      }));
    });
  }
}