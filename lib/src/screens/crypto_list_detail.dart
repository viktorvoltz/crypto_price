import 'package:flutter/material.dart';

import 'package:coingecko/src/model/coingeckoModel.dart';

class CryptoDetail extends StatefulWidget {
  final CoinGecko? detail;
  const CryptoDetail({this.detail, Key? key}) : super(key: key);

  @override
  State<CryptoDetail> createState() => _CryptoDetailState();
}

class _CryptoDetailState extends State<CryptoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detail!.name.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Market Cap: \$${widget.detail!.marketCap.toString()}"),
            Text("total volume: \$${widget.detail!.totalVolume.toString()}"),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("ATL: ${widget.detail!.atl.toString()}"),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text("ATH: ${widget.detail!.ath.toString()}"),
                ),
              ],
            ),
            SliderTheme(
              data: const SliderThemeData(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                showValueIndicator: ShowValueIndicator.always,
              ),
              child: Slider(
                value: widget.detail!.currentPrice!,
                max: widget.detail!.ath!,
                min: widget.detail!.atl!,
                onChanged: (double value){},
                label: widget.detail!.currentPrice.toString(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
