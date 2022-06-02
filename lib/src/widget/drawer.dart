import 'package:coingecko/src/widget/drawer_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
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
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const DrawerItem(),
          ],
        ),
      );
  }
}