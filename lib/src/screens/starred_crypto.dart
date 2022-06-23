import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/screens/crypto_list_detail.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:coingecko/src/widget/price_change.dart';

class StarredCrypto extends StatelessWidget {
  const StarredCrypto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    var starredList = busyHandler.getList();
    return Scaffold(
      appBar: AppBar(
        title: Text("${starredList.length} Starred Assets"),
      ),
      body: ListView.builder(
        itemCount: starredList.length,
        itemBuilder: (context, index) {
          if (starredList.isEmpty) {
            return const Center(
              child: Text("Your favourite coins will appear here."),
            );
          }
          return ListTile(
            leading: SizedBox(
              width: 40,
              height: 40,
              child: CachedNetworkImage(
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                imageUrl: starredList[index].image.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 30,
                  color: negative,
                ),
              ),
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CryptoDetail(
                    detail: starredList[index],
                  );
                }));
              },
              child: Text(starredList[index].name.toString()),
            ),
            subtitle: Text(
              '\$' +
                  starredList[index].currentPrice.toString() +
                  "   "
                      '(' +
                  starredList[index].symbol.toString().toUpperCase() +
                  ')',
              overflow: TextOverflow.clip,
            ),
            trailing: PriceChange(
              data: starredList,
              index: index,
            ),
          );
        },
      ),
    );
  }
}
