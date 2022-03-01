import 'package:coingecko/src/model/coingeckoModel.dart';

class Success{
  int? code;
  List<CoinGecko>? response;
  
  Success({
    this.code,
    this.response
  });
}

class Failure{
  int? code;
  String? response;

  Failure({
    this.code,
    this.response,
  });
}