import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:flutter/material.dart';

class CryptoDetail extends StatelessWidget {
  final CoinGecko? detail;
  const CryptoDetail({this.detail, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detail!.name.toString()),
      ),
      body: Center(
        child: Text(detail!.marketCap.toString()),
      ),
    );
  }
}