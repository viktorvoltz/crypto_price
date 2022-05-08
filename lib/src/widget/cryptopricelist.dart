import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/crypto_list_detail.dart';
import 'package:coingecko/src/services/http.dart';
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
  @override
  void initState() {
    super.initState();
    checkValue();
  }


  void checkValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getBool('fav${widget.snapshot!.data![widget.index!].id}');
    //print(widget.snapshot!.data![widget.index!].id);
    if(prefs.getBool('fav${widget.snapshot!.data![widget.index!].id}') == false || prefs.getBool('fav${widget.snapshot!.data![widget.index!].id}') == null){
      widget.snapshot!.data![widget.index!].isFavourited = false;
    }
    if(prefs.getBool('fav${widget.snapshot!.data![widget.index!].id}') == true){
      widget.snapshot!.data![widget.index!].isFavourited = true;
    }
    setState(() { 
    });
  }

  @override
  Widget build(BuildContext context) {
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      leading: SizedBox(
        width: 80,
        child: Row(
          children: [
            SizedBox(
              width: 25,
              child: GestureDetector(
                onTap: () async{
                  //busyHandler.favoriteFunc();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  setState(() {
                    if(widget.snapshot!.data![widget.index!].isFavourited == false){
                      prefs.setBool("fav${widget.snapshot!.data![widget.index!].id}", true);
                    }
                    if(widget.snapshot!.data![widget.index!].isFavourited == true){
                      prefs.setBool("fav${widget.snapshot!.data![widget.index!].id}", false);
                    }
                    widget.snapshot!.data![widget.index!].isFavourited = !widget.snapshot!.data![widget.index!].isFavourited;
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: widget.snapshot!.data![widget.index!].isFavourited
                      ? const Icon(Icons.star, color: Colors.black)
                      : const Icon(
                          Icons.star_border,
                          color: Colors.black,
                        ),
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
                imageUrl: widget.snapshot!.data![widget.index!].image.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 30,
                  color: Colors.red,
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
          style: GoogleFonts.titilliumWeb(fontSize: 25),
        ),
      ),
      subtitle: Text('\$' + widget.snapshot!.data![widget.index!].currentPrice.toString()),
      trailing: Text(
        widget.snapshot!.data![widget.index!].priceChange24H!.toStringAsFixed(3),
        style: widget.snapshot!.data![widget.index!].priceChange24H.toString().startsWith("-")
            ? GoogleFonts.titilliumWeb(
                fontWeight: FontWeight.w700, color: Colors.red)
            : GoogleFonts.titilliumWeb(
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 3, 150, 8)),
      ),
    );
  }
}
