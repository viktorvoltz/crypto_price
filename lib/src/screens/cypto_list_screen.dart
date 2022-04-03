import 'package:coingecko/src/blocs/coingecko_bloc.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:coingecko/src/screens/authscreen.dart';
import 'package:coingecko/src/utils/authentication.dart';
import 'package:coingecko/src/widget/cryptopricelist.dart';
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.zero,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!,
                      ),
                      radius: 40,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName!,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  try {
                    bloc.bSignOut(context).whenComplete(() {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const AuthScreen();
                          },
                        ),
                      );
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      Authentication.customSnackBar(
                        content: 'Error signing out. Try again.',
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: bloc.coinDataStream,
        builder: (context, AsyncSnapshot<List<CoinGecko>> snapshot) {
          if (snapshot.hasData) {
            return coinList(snapshot);
          } else if (snapshot.hasError) {
            return Center(child: Text(bloc.error!.response.toString()));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: 'price',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_important), label: 'notification'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account')
        ],
      ),
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
    return Center(child: Text(query));
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
                          showResults(context);
                        },
                        title: Text(itemList[index].name!),
                      )
                    ],
                  ));
            });
  }
}
