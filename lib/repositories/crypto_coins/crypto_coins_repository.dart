import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:project_crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:project_crypto/repositories/models/models.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {

  final Dio dio;
  final Box<CryptoCoinModel> cryptoCoinsBox;
  CryptoCoinsRepository({required this.dio, required this.cryptoCoinsBox});

  @override
  Future<List<CryptoCoinModel>> getCoinsList() async {
    var cryptoCoinList = <CryptoCoinModel>[];
    try {
      cryptoCoinList = await _fetchCoinsListFromApi();
      
      final cryptoCoinsMap = { for (var e in cryptoCoinList) e.name: e };
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (e,st) {
      GetIt.instance<Talker>().handle(e, st);
      cryptoCoinList = cryptoCoinsBox.values.toList();

    }

    cryptoCoinList.sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));

    return cryptoCoinList;
  }

  Future<List<CryptoCoinModel>> _fetchCoinsListFromApi() async {
       final response = await dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,CAG,DOV,AID&tsyms=USD');
    final data =  response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    final cryptoCoinList = dataRaw.entries.map((el) {
      final usdData = (el.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);

      return CryptoCoinModel(
          name: el.key,
          details: details
      );
    }).toList();
    return cryptoCoinList;
  }

  @override
  Future<CryptoCoinModel> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      return cryptoCoinsBox.get(currencyCode)!;
    }

  }

  Future<CryptoCoinModel> _fetchCoinDetailsFromApi(String currencyCode) async {
       final response = await dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');
    
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);
    return CryptoCoinModel(name: currencyCode, details: details);


  }



}