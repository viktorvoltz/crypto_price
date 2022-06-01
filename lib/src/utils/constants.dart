import 'package:flutter/material.dart';

const String API_KEY = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';

const String themeMode = "themeMode";

/// price change color themes
const Color positive = Color.fromARGB(255, 3, 150, 8);
const Color negative = Color.fromARGB(255, 207, 24, 11);