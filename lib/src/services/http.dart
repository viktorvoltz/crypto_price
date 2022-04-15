import 'dart:io';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'httpStatus.dart';
import 'package:path_provider/path_provider.dart';

class CoinGeckoData {
  static bool _isFromCache = false;
  static bool _getRequestSuccess = false;

  bool get isFromCache => _isFromCache;

  static late File _file;

  static void cacheChecker() {
    _isFromCache = true;
  }

  static Future<Object> getData() async {
    String coinFile = "coindata.json";
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + coinFile);
    _file = file;

    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      Success res = Success(
        response: coinGeckoFromJson(jsonData),
      );
      print('loading from cache');
      cacheChecker();
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
        //} on HttpException {
        //return Failure(code: 101, response: 'No Internet');
      } on FormatException {
        return Failure(code: 102, response: 'Invalid Format');
      } catch (e) {
        //return Failure(code: 103, response: 'Invalid Response');
        if (_getRequestSuccess == false) retryFuture(getData, 2000);
      }
    }
    return Failure(code: 100, response: 'Invalid Response');
  }

  static retryFuture(future, delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }

  static Future<Object> refreshData() async {
    try{
      final response = await http.get(
        Uri.parse(API_KEY)
      );

      if(response.statusCode == 200){
        _file.writeAsStringSync(
            response.body,
            flush: true,
            mode: FileMode.write,
          );
      }
    }catch(e){

    }
  }
}
