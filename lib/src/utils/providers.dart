import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:coingecko/src/blocs/busyHandler.dart';
import 'package:coingecko/src/blocs/theme_provider.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => BusyHandler()),
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
];
