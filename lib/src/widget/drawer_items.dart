import 'package:coingecko/src/blocs/coingecko_bloc.dart';
import 'package:coingecko/src/blocs/theme_provider.dart';
import 'package:coingecko/src/screens/authscreen.dart';
import 'package:coingecko/src/screens/starred_crypto.dart';
import 'package:coingecko/src/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
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
        ListTile(
          leading: const Icon(
            Icons.star,
          ),
          title: const Text(
            "Starred Assets",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const StarredCrypto();
                },
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.light_mode),
                  Container(
                    child: FlatButton(
                      onPressed: () => {
                        themeChange.setLightMode(),
                      },
                      child: const Text('Set Light Theme'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.dark_mode),
                  Container(
                    child: FlatButton(
                      onPressed: () => {
                        themeChange.setDarkMode(),
                      },
                      child: const Text('Set Dark theme'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
