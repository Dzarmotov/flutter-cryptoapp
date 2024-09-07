import 'package:project_crypto/repositories/models/models.dart';

abstract class AbstractCoinsRepository {
  Future<List<CryptoCoinModel>> getCoinsList();
  Future<CryptoCoinModel> getCoinDetails(String currencyCode);
}