import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail {

  @HiveField(0)
  @JsonKey(name: 'TOSYMBOL')
  final String name;

  @HiveField(1)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @HiveField(2)
  @JsonKey(name: 'IMAGEURL')
  final String imageURL;

  String get fullImageUrl => 'https://cryptocompare.com/$imageURL';

  // @JsonKey(name: 'TOSYMBOL')
  // final String toSymbol;

  @HiveField(3)
  @JsonKey(name: 'LASTUPDATE', toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime lastUpdate;

  @HiveField(4)
  @JsonKey(name: 'HIGHT24HOUR')
  final double hight24Hour;

  @HiveField(5)
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hours;

  CryptoCoinDetail({
    required this.name,
    required this.priceInUSD,
    required this.imageURL,
    // required this.toSymbol,
   required this.lastUpdate,
    required this.hight24Hour,
    required this.low24Hours
  });

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;
  static DateTime _dateTimeFromJson(int miliseconds) => DateTime.fromMillisecondsSinceEpoch(miliseconds);

  @override
  List<Object?> get props => [name, priceInUSD, imageURL,lastUpdate, hight24Hour, low24Hours];
}