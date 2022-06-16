import 'dart:ui';

import 'package:coingecko/src/model/chart_data.dart';
import 'package:coingecko/src/services/http.dart';
import 'package:coingecko/src/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:coingecko/src/model/coingeckoModel.dart';
import 'package:fl_chart/fl_chart.dart';

class CryptoDetail extends StatefulWidget {
  final CoinGecko? detail;
  const CryptoDetail({this.detail, Key? key}) : super(key: key);

  @override
  State<CryptoDetail> createState() => _CryptoDetailState();
}

class _CryptoDetailState extends State<CryptoDetail> {
  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = <Color>[
      widget.detail!.priceChangePercentage24H! < 0 ? Colors.redAccent : Colors.greenAccent,
      widget.detail!.priceChangePercentage24H! < 0 ? const Color.fromARGB(255, 245, 206, 206) : const Color.fromARGB(255, 189, 241, 191),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detail!.name.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 400,
              child: FutureBuilder<ChartData>(
                  future: CoinGeckoData.chartData(id: widget.detail!.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              barWidth: 0.7,
                              spots: snapshot.data!.prices!
                                  .map((point) => FlSpot(point[0], point[1]))
                                  .toList(),
                              isCurved: false,
                              dotData: FlDotData(
                                show: false,
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: gradientColors
                                ),
                              )
                            ),
                          ],
                          gridData: FlGridData(
                            show: false,
                            drawVerticalLine: true,
                            getDrawingHorizontalLine: (double value) {
                              return FlLine(
                                color:
                                    widget.detail!.priceChangePercentage24H! < 0
                                        ? negative
                                        : positive,
                                strokeWidth: 1,
                              );
                            },
                            getDrawingVerticalLine: (double value) {
                              return FlLine(
                                color:
                                    widget.detail!.priceChangePercentage24H! < 0
                                        ? negative
                                        : positive,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 60,
                                showTitles: true,
                                /*getTitlesWidget: (double tr, TitleMeta yu) =>
                                    Container(
                                  width: double.infinity,
                                  color: Colors.red,
                                  child: Text(
                                    tr.toString(),
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),*/
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                        ),
                        swapAnimationCurve: Curves.linear,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: double.infinity,
                        child: const Text("loading chart"),
                      );
                    }
                    return const Center(child: Text("Error loading chart"));
                  }),
            ),
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
                onChanged: (double value) {},
                label: widget.detail!.currentPrice.toString(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
