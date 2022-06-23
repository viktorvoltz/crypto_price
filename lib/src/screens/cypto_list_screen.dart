import 'package:coingecko/src/screens/crypto_list_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/blocs/coingecko_bloc.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/widget/cryptopricelist.dart';
import 'package:coingecko/src/widget/drawer.dart';
import 'package:coingecko/src/screens/starred_crypto.dart';

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
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Crypto price",
          overflow: TextOverflow.fade,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const StarredCrypto();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.star,
            ),
          ),
          Center(
            child: Text(
              DateFormat('EEEE, LLL dd').format(DateTime.now()),
              style: GoogleFonts.titilliumWeb(),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CryptoSearch());
            },
            icon: const Icon(
              Icons.search,
            ),
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
                      busyHandler.refStatus
                          ? TextButton(
                              onPressed: () async {
                                busyHandler.refreshStatus();
                                await bloc.refreshData();
                              },
                              child: const Text("Try Again"),
                            )
                          : const Center(child: CircularProgressIndicator()),
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
    return CryptoDetail(detail: coindata);
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
                        subtitle: Text(itemList[index].symbol!.toUpperCase()),
                      )
                    ],
                  ));
            });
  }
}
