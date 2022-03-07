import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/services/http.dart';
import 'package:coingecko/src/services/httpStatus.dart';
import 'package:rxdart/rxdart.dart';

class CoingeckoBloc {
  Failure? _error;
  Failure? get error => _error;
  final _coinDataFetcher = PublishSubject<List<CoinGecko>>();

  List<CoinGecko> _coinList = [];
  List<CoinGecko>? get coinList => _coinList;

  Stream<List<CoinGecko>> get coinDataStream => _coinDataFetcher.stream;

  setError(Failure error) {
    _error = error;
  }

  setCoinList(List<CoinGecko> coinList){
    _coinList = coinList;
  }

  getCoinData() async {
    var response = await CoinGeckoData.getData();
    if (response is Success) {
      List<CoinGecko> coinGecko = response.response!;
      _coinDataFetcher.sink.add(coinGecko);
      _coinList = [...coinGecko];
      ///_coinList.add(coinGecko as CoinGecko);
      setCoinList(_coinList);
    } else if (response is Failure) {
      Failure error = Failure(code: response.code, response: response.response);
      setError(error);
    }
  }

  dispose() {
    _coinDataFetcher.close();
  }
}

final bloc = CoingeckoBloc();
