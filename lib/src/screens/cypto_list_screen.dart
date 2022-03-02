import 'dart:async';

import 'package:coingecko/src/blocs/coingecko_bloc.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/services/httpStatus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CryptoList extends StatefulWidget {
  const CryptoList({Key? key}) : super(key: key);

  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  @override
  void initState() {
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
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Crypto price List",
          style: GoogleFonts.titilliumWeb(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: Text(
              DateFormat('EEEE, LLL dd').format(DateTime.now()),
              style: GoogleFonts.titilliumWeb(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: StreamBuilder(
        stream: bloc.coinDataStream,
        builder: (context, AsyncSnapshot<List<CoinGecko>> snapshot) {
          if (snapshot.hasData) {
            return coinList(snapshot);
          } else if (snapshot.hasError){
            return Center(child: Text(bloc.error!.response.toString()));
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            leading: SizedBox(
              height: 40,
              child: Image.network(snapshot.data![index].image.toString()),
            ),
            title: Text(
              snapshot.data![index].name.toString(),
              style: GoogleFonts.titilliumWeb(fontSize: 25),
            ),
            subtitle:
                Text('\$' + snapshot.data![index].currentPrice.toString()),
            trailing: Text(
              snapshot.data![index].priceChange24H!.toStringAsFixed(3),
              style: snapshot.data![index].priceChange24H
                      .toString()
                      .startsWith("-")
                  ? GoogleFonts.titilliumWeb(
                      fontWeight: FontWeight.w700, color: Colors.red)
                  : GoogleFonts.titilliumWeb(
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 3, 150, 8)),
            ),
          );
        });
  }
}
