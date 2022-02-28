import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/services/http.dart';
import 'package:coingecko/src/services/httpStatus.dart';
import 'package:flutter/material.dart';

class CoinGeckoProvider extends ChangeNotifier{
  bool _isLoading = false;
  CoinGecko? _coinData;
  Failure? _error;

  bool get loading => _isLoading;
  CoinGecko? get coinData => _coinData;
  Failure? get error => _error;

  CoinGeckoProvider(){
    getData();
  }

  setLoading(bool loading) async{
    _isLoading = loading;
    notifyListeners();
  }

  setPokemonData(CoinGecko coinData){
    _coinData = coinData;
    notifyListeners();
  }

  setError(Failure error){
    _error = error;
  }

  getData() async{
    setLoading(true);
    var response = await CoinGeckoData.getData();
    if (response is Success){
      setPokemonData(response.response as CoinGecko);
    }
    if (response is Failure){
      Failure error = Failure(
        code: response.code,
        response: response.response
      );
      setError(error);
    }
    setLoading(false);
  }

}