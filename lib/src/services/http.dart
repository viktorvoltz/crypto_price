import 'dart:io';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'httpStatus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';


class CoinGeckoData {
  static Future<Object> getData() async {

    String coinFile = "coindata.json";
    var dir = await getTemporaryDirectory();

    File file =  File(dir.path+"/"+coinFile);

    if(file.existsSync()){
      var jsonData = file.readAsStringSync();
      Success res = Success(response: coinGeckoFromJson(jsonData));
      print('loading from cache');
      return res;
    }else{
      try {
      final response = await http.get(
        Uri.parse(API_KEY),
      );
      if (response.statusCode == 200) {
        print('loading from API');
        file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
        return Success(response: coinGeckoFromJson(response.body));
      }
    } on HttpException {
      return Failure(code: 101, response: 'No Internet');
    } on FormatException {
      return Failure(code: 102, response: 'Invalid Format');
    } catch (e) {
      return Failure(code: 103, response: 'Invalid Response');
    }
    }
    return Failure(code: 100, response: 'Invalid Response');
  }
}