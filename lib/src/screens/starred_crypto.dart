import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StarredCrypto extends StatelessWidget {
  const StarredCrypto({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    var starredList = busyHandler.getList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Starred Assets"),
      ),
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