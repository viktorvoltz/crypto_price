import 'package:coingecko/src/blocs/coingecko_bloc.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/authscreen.dart';
import 'package:coingecko/src/services/httpStatus.dart';
import 'package:coingecko/src/utils/authentication.dart';
import 'package:coingecko/src/widget/cryptopricelist.dart';
import 'package:coingecko/src/widget/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      appBar: AppBar(
        foregroundColor: Colors.black,
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
          ),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CryptoSearch());
            },
            icon: const Icon(Icons.search, color: Colors.black),
          )
        ],
      ),
      drawer: const DrawerWidget(),
      body: RefreshIndicator(
          onRefresh: bloc.refreshData,
          child: StreamBuilder(
            stream: bloc.coinDataStream,
            builder: (context, AsyncSnapshot<List<CoinGecko>> snapshot) {
              if (snapshot.hasData) {
                return coinList(snapshot);
              } else if (snapshot.hasError) {
                print("failed to refresh");
                //bloc.getCoinData();
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bloc.error!.response.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: bloc.refreshData,
                        child: const Text("Try Again"),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }

  Widget coinList(AsyncSnapshot<List<CoinGecko>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return CryptoPriceList(
            snapshot: snapshot,
            index: index,
          );
        });
  }
}

class CryptoSearch extends SearchDelegate<CoinGecko> {
  late CoinGecko coindata;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.navigate_before),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(coindata.name!),
        Text(coindata.priceChange24H!.toString()),
      ],
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final itemList = query.isEmpty
        ? bloc.coinList
        : bloc.coinList!
            .where((element) =>
                element.name!.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return itemList!.isEmpty
        ? const Center(child: Text("coin not found"))
        : ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          coindata = itemList[index];
                          query = itemList[index].name!;
                          showResults(context);
                        },
                        title: Text(itemList[index].name!),
                      )
                    ],
                  ));
            });
  }
}
