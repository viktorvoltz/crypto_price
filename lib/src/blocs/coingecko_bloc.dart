import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/cypto_list_screen.dart';
import 'package:coingecko/src/services/http.dart';
import 'package:coingecko/src/services/httpStatus.dart';
import 'package:coingecko/src/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CoingeckoBloc {
  Failure? _error;
  Failure? get error => _error;
  final _coinDataFetcher = PublishSubject<List<CoinGecko>>();

  List<CoinGecko> _coinList = [];
  List<CoinGecko>? get coinList => _coinList;
  bool get isbusy => _isbusy;

  Stream<List<CoinGecko>> get coinDataStream => _coinDataFetcher.stream;

  User? _user;

  User? get user => _user;

  setError(Failure error) {
    _error = error;
  }

  setCoinList(List<CoinGecko> coinList) {
    _coinList = coinList;
  }

  bool _isbusy = false;
  Future<void> bSigninWithGoogle(BuildContext context) async {
    _isbusy = true;
    _user = await Authentication.signInWithGoogle(context: context).whenComplete(() {
      _isbusy = false;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const CryptoList();
      }));
    });
  }

  Future<void> bSignOut(BuildContext context) async{
    await Authentication.signOut(context: context);
  }

  Future<void> getCoinData() async {
    var response = await CoinGeckoData.getData();
    if (response is Success) {
      List<CoinGecko> coinGecko = response.response!;
      if(!_isdisposed){
        _coinDataFetcher.sink.add(coinGecko);
      }
      _coinList = [...coinGecko];

      ///_coinList.add(coinGecko as CoinGecko);
      setCoinList(_coinList);
    } else if (response is Failure) {
      Failure error = Failure(code: response.code, response: response.response);
      setError(error);
    }
  }

  Future<void> refreshData() async {
    var response = await CoinGeckoData.refreshData();
    if (response is Success) {
      List<CoinGecko> coinGecko = response.response!;
      if(!_isdisposed){
        _coinDataFetcher.sink.add(coinGecko);
      }
      _coinList = [...coinGecko];

      setCoinList(_coinList);
    } else if (response is Failure) {
      Failure error = Failure(code: response.code, response: response.response);
      setError(error);
    }
  }

  bool _isdisposed = false;
  dispose() async{
    await _coinDataFetcher.drain();
    _coinDataFetcher.close();
    _isdisposed = true;
  }
}

final bloc = CoingeckoBloc();
