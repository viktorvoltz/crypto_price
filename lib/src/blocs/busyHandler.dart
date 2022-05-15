
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/cypto_list_screen.dart';
import 'package:coingecko/src/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusyHandler extends ChangeNotifier{
  User? _user;
  bool _isbusy = false;
  bool _refStatus = true;
  List<CoinGecko> _starredList = [];

  bool get isbusy => _isbusy;
  bool get refStatus => _refStatus;
  List<CoinGecko> get starredList => _starredList;

  void refreshStatus(){
    _refStatus = !_refStatus;
    notifyListeners();
  }

  List<CoinGecko> getList(){
    List<CoinGecko> list = _starredList.where((element) => element.isFavourited == true) as List<CoinGecko>;
    return list;
  }


  void setList(List<CoinGecko> list){
    _starredList = list;
  }

  Future<List<CoinGecko>> getStarredList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String list = prefs.getString("fav_coins") ?? "null";
    final List<CoinGecko> coinList = coinGeckoFromJson(list);
    return coinList;
  }

  void addToStarredList(CoinGecko item, int integer) async{
    _starredList.add(item);
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String stringData = coinGeckoToJson(_starredList);
    await prefs.setString("fav_coins", stringData);
  }

  void removeFromStarredList(int item)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("fav_coins");
  }

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