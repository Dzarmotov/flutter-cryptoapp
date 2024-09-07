part of 'crypto_coin_details_bloc.dart';

abstract class CryptoCoinDetailsEvent extends Equatable{}

class LoadCryptoDetail extends CryptoCoinDetailsEvent {
  final String currencyCode;

  LoadCryptoDetail({required this.currencyCode});

  @override
  List<Object?> get props => [currencyCode];
}
