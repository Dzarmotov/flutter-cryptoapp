import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_crypto/crypto_app.dart';
import 'package:project_crypto/firebase_options.dart';
import 'package:project_crypto/repositories/models/crypto_coin.dart';
import 'package:project_crypto/repositories/models/crypto_coin_details.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:project_crypto/repositories/crypto_coins/crypto_coins_repository.dart';



void main() async {

  final talker = TalkerFlutter.init();
  GetIt.instance.registerSingleton(talker);

  const cryptoCoinBoxName = 'crypto_coin_box';

  await Hive.initFlutter();

  Hive.registerAdapter(CryptoCoinModelAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  var cryptoCoinsBox = await Hive.openBox<CryptoCoinModel>(cryptoCoinBoxName);

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  talker.info(app.options.projectId);

  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printResponseData: false
    )
  ));

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    )
  );

  GetIt.instance.registerLazySingleton<AbstractCoinsRepository>(() => CryptoCoinsRepository(cryptoCoinsBox: cryptoCoinsBox, dio: dio));

  FlutterError.onError = (details) => GetIt.instance<Talker>().handle(details.exception, details.stack);

  await runZonedGuarded(() async{
    WidgetsFlutterBinding.ensureInitialized();
    return runApp(const CryptoApp());
  }, (error, stack) => GetIt.instance<Talker>().handle(error,stack));
}



