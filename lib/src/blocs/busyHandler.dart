import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/cypto_list_screen.dart';
import 'package:coingecko/src/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusyHandler extends ChangeNotifier {
  User? _user;
  bool _isbusy = false;
  bool _refStatus = true;
  List<CoinGecko> _starredList = [];

  bool get isbusy => _isbusy;
  bool get refStatus => _refStatus;
  List<CoinGecko> get starredList => _starredList;

  void refreshStatus() {
    _refStatus = !_refStatus;
    notifyListeners();
  }

  List<CoinGecko> getList() {
    //var list = _starredList.where((element) => element.isFavourited == true);
    //return list.toList();
    print(_starredList);
    return _starredList;
  }

  void setList(List<CoinGecko> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<CoinGecko> _try = list
        .where((element) => prefs.getBool('fav${element.id}') == true)
        .toList();
    //notifyListeners();
    //_starredList = list;
    _starredList = _try;
    print("sss$_starredList");
  }

  Future<void> bSigninWithGoogle(BuildContext context) async {
    _isbusy = true;
    notifyListeners();
    _user = await Authentication.signInWithGoogle(context: context)
        .whenComplete(() {
      _isbusy = false;
      notifyListeners();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const CryptoList();
      }));
    });
  }
}
