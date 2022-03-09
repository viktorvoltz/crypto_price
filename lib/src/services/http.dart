import 'dart:io';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'httpStatus.dart';
import 'package:path_provider/path_provider.dart';

class CoinGeckoData {
  static Future<Object> getData() async {

    String coinFile = "coindata.json";
    var dir = await getTemporaryDirectory();

    File file =  File(dir.path+"/"+coinFile);

    try {
      final response = await http.get(
        Uri.parse(API_KEY),
      );
      if (response.statusCode == 200) {
        return Success(response: coinGeckoFromJson(response.body));
      }
      return Failure(code: 100, response: 'Invalid Response');
    } on HttpException {
      return Failure(code: 101, response: 'No Internet');
    } on FormatException {
      return Failure(code: 102, response: 'Invalid Format');
    } catch (e) {
      return Failure(code: 103, response: 'Invalid Response');
    }
  }
}