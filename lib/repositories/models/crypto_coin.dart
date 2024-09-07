import 'package:hive_flutter/adapters.dart';
import 'package:equatable/equatable.dart';
import 'package:project_crypto/repositories/models/crypto_coin_details.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: 2)
class CryptoCoinModel extends Equatable{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final CryptoCoinDetail details;

  const CryptoCoinModel({required this.name, required this.details});

  @override
  List<Object?> get props => [name, details];

}

