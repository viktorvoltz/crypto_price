import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BusyHandler busyHandler = Provider.of<BusyHandler>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 200,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              //color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image/search.png",
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(width: 5,),
                  TextButton(
                    onPressed: () async {
                      await busyHandler.bSigninWithGoogle(context);
                    },
                    child: const Text(
                      "Signin with Google",
                      //style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            busyHandler.isbusy ? const CircularProgressIndicator(color: Colors.black,) : Container()
          ],
        ),
      ),
    );
  }
}
