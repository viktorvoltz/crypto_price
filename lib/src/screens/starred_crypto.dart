import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:coingecko/src/widget/price_change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StarredCrypto extends StatelessWidget {
  const StarredCrypto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    var starredList = busyHandler.getList();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Starred Assets"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: ListView.builder(
            itemCount: starredList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  width: 40,
                  height: 40,
                  child: CachedNetworkImage(
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    imageUrl: starredList[index].image.toString(),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 30,
                      color: negative,
                    ),
                  ),
                ),
                title: Text(starredList[index].name.toString()),
                subtitle: Text(
                  '\$' +
                      starredList[index].currentPrice.toString() +
                      "   "
                          '(' +
                      starredList[index].symbol.toString().toUpperCase() +
                      ')',
                  overflow: TextOverflow.clip,
                ),
                trailing: PriceChange(data: starredList, index: index,),
              );
            }));
  }
}
