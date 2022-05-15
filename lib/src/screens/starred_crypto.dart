import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StarredCrypto extends StatelessWidget {
  const StarredCrypto({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    var starredList = busyHandler.getList();
    return Scaffold(
      body: ListView.builder(
            itemCount: starredList.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(starredList[index].name.toString()),
              );
          })
    );
  }
}