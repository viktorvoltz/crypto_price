import 'dart:io';
import 'package:coingecko/src/model/chart_data.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'httpStatus.dart';
import 'package:path_provider/path_provider.dart';

class CoinGeckoData {
  static bool _getRequestSuccess = false;

  static File _file = File(".");
  static Future<Object> getData() async {
    String coinFile = "coindata.json";
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + coinFile);
    if (_file.existsSync()) file = _file;
    _file = file;

    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      Success res = Success(
        response: coinGeckoFromJson(jsonData),
      );
      print('loading from cache');
      // delete cache data after one minute of loading
      Future.delayed(const Duration(minutes: 1), () async {
        await file.delete();
      });
      return res;
    } else {
      try {
        final response = await http.get(
          Uri.parse(API_KEY),
        );
        if (response.statusCode == 200) {
          _getRequestSuccess = true;
          print('loading from API');
          file.writeAsStringSync(
            response.body,
            flush: true,
            mode: FileMode.write,
          );

          return Success(
            response: coinGeckoFromJson(response.body),
          );
        }
      } on FormatException {
        return Failure(code: 102, response: 'Invalid Format');
      } catch (e) {
        // automatic refresh if initial api call fails
        if (_getRequestSuccess == false) retryFuture(getData, 2000);
      }
    }
    return Failure(code: 100, response: 'Invalid Response');
  }

  static retryFuture(Function future, int delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }

  /// dedicated method for refreshing api data.
  static Future<Object> refreshData() async {
    try {
      final response = await http.get(Uri.parse(API_KEY));

      if (response.statusCode == 200) {
        print('refresh from API');
        _file.writeAsStringSync(
          response.body,
          flush: true,
          mode: FileMode.write,
        );

        return Success(
          response: coinGeckoFromJson(response.body),
        );
      }
    } on HttpException {
      return Failure(code: 101, response: "No internet");
    }
    return Failure(code: 100, response: 'Invalid Response');
  }

  /// get chart data.
  static Future<ChartData> chartData({String id = "bitcoin"}) async {
    try {
      final response = await http.get(
          Uri.parse(apiChartKey + id + '/market_chart?vs_currency=usd&days=1'));

      if (response.statusCode == 200) {
        return chartDataFromJson(response.body);
      }
    } on HttpException {
      //return Failure(code: 101, response: "No internet");
      return ChartData();
    }
    //return Failure(code: 100, response: 'Invalid Response');
    return ChartData();
  }
}
