import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceChange extends StatelessWidget {
  final List<CoinGecko>? data;
  final int? index;
  const PriceChange({this.data, this.index, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String priceChangePercentage24H = data![index!].priceChangePercentage24H
        .toString();
    return Container(
      width: 95,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            priceChangePercentage24H.startsWith("-")
                ? Icons.arrow_drop_down
                : Icons.arrow_drop_up,
            color:
                priceChangePercentage24H.startsWith("-") ? negative : positive,
          ),
          Text(
            "${data![index!].priceChangePercentage24H!.toStringAsFixed(3)}  %",
            overflow: TextOverflow.clip,
            style: priceChangePercentage24H.toString().startsWith("-")
                ? GoogleFonts.titilliumWeb(
                    fontWeight: FontWeight.w700, color: negative)
                : GoogleFonts.titilliumWeb(
                    fontWeight: FontWeight.w700, color: positive),
          ),
        ],
      ),
    );
  }
}