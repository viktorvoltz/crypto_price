import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StarredCrypto extends StatelessWidget {
  const StarredCrypto({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    return Scaffold(
      body: FutureBuilder<List<CoinGecko>>(
        future: busyHandler.getStarredList(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(snapshot.data![index].name.toString()),
              );
          });
          }
          return Container();
        }
      ),
    );
  }
}