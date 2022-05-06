import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/crypto_list_detail.dart';
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
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return CryptoDetail(detail: snapshot!.data![index!],);
        }));
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      leading: SizedBox(
        width: 40,
        height: 40,
        child: CachedNetworkImage(
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          imageUrl: snapshot!.data![index!].image.toString(),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 30,
            color: Colors.red,
          ),
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
