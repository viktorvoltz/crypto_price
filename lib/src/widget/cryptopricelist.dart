import 'dart:io';

import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/services/http.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CryptoPriceList extends StatelessWidget {
  final AsyncSnapshot<List<CoinGecko>>? snapshot;
  final int? index;
  const CryptoPriceList({Key? key, this.snapshot, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      leading: SizedBox(
        height: 40,
        child: CoinGeckoData.cacheChecker()
            ? Image.file(File(snapshot!.data![index!].image.toString()))
            : Image.network(
                snapshot!.data![index!].image.toString(),
              ),
      ),
      title: Text(
        snapshot!.data![index!].name.toString(),
        style: GoogleFonts.titilliumWeb(fontSize: 25),
      ),
      subtitle: Text('\$' + snapshot!.data![index!].currentPrice.toString()),
      trailing: Text(
        snapshot!.data![index!].priceChange24H!.toStringAsFixed(3),
        style: snapshot!.data![index!].priceChange24H.toString().startsWith("-")
            ? GoogleFonts.titilliumWeb(
                fontWeight: FontWeight.w700, color: Colors.red)
            : GoogleFonts.titilliumWeb(
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 3, 150, 8)),
      ),
    );
  }
}
