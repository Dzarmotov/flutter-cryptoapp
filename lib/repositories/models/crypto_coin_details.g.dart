// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoCoinDetailAdapter extends TypeAdapter<CryptoCoinDetail> {
  @override
  final int typeId = 1;

  @override
  CryptoCoinDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoCoinDetail(
      name: fields[0] as String,
      priceInUSD: fields[1] as double,
      imageURL: fields[2] as String,
      lastUpdate: fields[3] as DateTime,
      hight24Hour: fields[4] as double,
      low24Hours: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoCoinDetail obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.priceInUSD)
      ..writeByte(2)
      ..write(obj.imageURL)
      ..writeByte(3)
      ..write(obj.lastUpdate)
      ..writeByte(4)
      ..write(obj.hight24Hour)
      ..writeByte(5)
      ..write(obj.low24Hours);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCoinDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetail _$CryptoCoinDetailFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetail(
      name: json['TOSYMBOL'] as String,
      priceInUSD: (json['PRICE'] as num).toDouble(),
      imageURL: json['IMAGEURL'] as String,
      lastUpdate: CryptoCoinDetail._dateTimeFromJson(
          (json['LASTUPDATE'] as num).toInt()),
      hight24Hour: (json['HIGH24HOUR'] as num).toDouble(),
      low24Hours: (json['LOW24HOUR'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoCoinDetailToJson(CryptoCoinDetail instance) =>
    <String, dynamic>{
      'TOSYMBOL': instance.name,
      'PRICE': instance.priceInUSD,
      'IMAGEURL': instance.imageURL,
      'LASTUPDATE': CryptoCoinDetail._dateTimeToJson(instance.lastUpdate),
      'HIGHT24HOUR': instance.hight24Hour,
      'LOW24HOUR': instance.low24Hours,
    };
