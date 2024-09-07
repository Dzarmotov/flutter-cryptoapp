import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_crypto/router/router.dart';
import 'package:project_crypto/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoApp extends StatefulWidget {
  const CryptoApp({super.key});

  @override
  State<CryptoApp> createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      routes: routes,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.instance<Talker>())
      ],
    );
  }
}
