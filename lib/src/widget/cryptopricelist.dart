import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/crypto_list_detail.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:coingecko/src/utils/favourite_check.dart';
import 'package:coingecko/src/widget/price_change.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CryptoPriceList extends StatefulWidget {
  final AsyncSnapshot<List<CoinGecko>>? snapshot;
  final int? index;
  const CryptoPriceList({Key? key, this.snapshot, this.index})
      : super(key: key);

  @override
  State<CryptoPriceList> createState() => _CryptoPriceListState();
}

class _CryptoPriceListState extends State<CryptoPriceList> {
  Favourite favourite = Favourite();

  @override
  void initState() {
    super.initState();
    //checkValue();
  }

  void checkValue() async {
    await favourite.getFavourite(widget.snapshot!, widget.index!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    busyHandler.setList(widget.snapshot!.data!);
    checkValue();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      leading: SizedBox(
        width: 80,
        child: Row(
          children: [
            SizedBox(
              width: 25,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    favourite.setFavourite(widget.snapshot!, widget.index!);
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: double.infinity,
                      child: widget.snapshot!.data![widget.index!].isFavourited
                          ? const Icon(
                              Icons.star,
                            )
                          : const Icon(
                              Icons.star_border,
                            ),
                    ),
                    Text(widget.snapshot!.data![widget.index!].marketCapRank.toString())
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 40,
              height: 40,
              child: CachedNetworkImage(
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                imageUrl:
                    widget.snapshot!.data![widget.index!].image.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 30,
                  color: negative,
                ),
              ),
            ),
          ],
        ),
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CryptoDetail(
              detail: widget.snapshot!.data![widget.index!],
            );
          }));
        },
        child: Text(
          widget.snapshot!.data![widget.index!].name.toString(),
          overflow: TextOverflow.clip,
          style: GoogleFonts.titilliumWeb(fontSize: 25),
        ),
      ),
      subtitle: Text(
        '\$' +
            widget.snapshot!.data![widget.index!].currentPrice.toString() +
            "   "
                '(' +
            widget.snapshot!.data![widget.index!].symbol
                .toString()
                .toUpperCase() +
            ')',
        overflow: TextOverflow.clip,
      ),
      trailing: PriceChange(data: widget.snapshot!.data!, index: widget.index),
    );
  }
}
