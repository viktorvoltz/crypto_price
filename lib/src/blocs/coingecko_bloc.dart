import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/services/http.dart';
import 'package:coingecko/src/services/httpStatus.dart';
import 'package:rxdart/rxdart.dart';

class CoingeckoBloc{
  final _coinDataFetcher = PublishSubject<List<CoinGecko>>();

  Stream<List<CoinGecko>> get coinDataStream => _coinDataFetcher.stream;

  getCoinData() async {
    var response = await CoinGeckoData.getData();
    if (response is Success){
      List<CoinGecko> coinGecko = response.response!;
      _coinDataFetcher.sink.add(coinGecko);
    }
  }

  dispose(){
    _coinDataFetcher.close();
  }
}

final bloc = CoingeckoBloc();