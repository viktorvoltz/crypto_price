import 'package:coingecko/src/blocs/coingecko_bloc.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CryptoList extends StatefulWidget {
  const CryptoList({Key? key}) : super(key: key);

  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  @override
  void initState() {
    bloc.getCoinData();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.coinDataStream,
        builder: (context, AsyncSnapshot<List<CoinGecko>> snapshot) {
          if (snapshot.hasData) {
            return coinList(snapshot);
          } else if (snapshot.hasError) {
            Text(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget coinList(AsyncSnapshot<List<CoinGecko>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: SizedBox(
              height: 50,
              child: Image.network(snapshot.data![index].image.toString()),
            ),
            title: Text(snapshot.data![index].name.toString()),
            trailing: Text(
              snapshot.data![index].priceChange24H.toString(),
              style: snapshot.data![index].priceChange24H
                      .toString()
                      .startsWith("-")
                  ? GoogleFonts.titilliumWeb(fontWeight: FontWeight.w700, color: Colors.red)
                  : GoogleFonts.titilliumWeb(fontWeight: FontWeight.w700, color: Colors.green),
            ),
          );
        });
  }
}
