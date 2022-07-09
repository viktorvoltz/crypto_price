import 'package:flutter/material.dart';

import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourite {

  Favourite();

  Future<void> getFavourite(AsyncSnapshot<List<CoinGecko>> snapshot, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('fav${snapshot.data![index].id}') == false ||
        prefs.getBool('fav${snapshot.data![index].id}') == null) {
      snapshot.data![index].isFavourited = false;
    }
    if (prefs.getBool('fav${snapshot.data![index].id}') == true) {
      snapshot.data![index].isFavourited = true;
    }
  }

  void setFavourite(AsyncSnapshot<List<CoinGecko>> snapshot, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (snapshot.data![index].isFavourited == false) {
      prefs.setBool("fav${snapshot.data![index].id}", true);
    }
    if (snapshot.data![index].isFavourited == true) {
      prefs.setBool("fav${snapshot.data![index].id}", false);
    }
    snapshot.data![index].isFavourited = !snapshot.data![index].isFavourited;
  }
}
