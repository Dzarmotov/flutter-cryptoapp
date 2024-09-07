part of 'crypto_coin_details_bloc.dart';

abstract class CryptoCoinDetailsState extends Equatable {}

class CryptoCoinDetailsInitial extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoading extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoaded extends CryptoCoinDetailsState {
  final CryptoCoinModel coinDetail;

  CryptoCoinDetailsLoaded({required this.coinDetail});
  @override
  List<Object?> get props => [coinDetail];
}

class CryptoCoinDetailsFailed extends CryptoCoinDetailsState {
  final Object? exception;

  CryptoCoinDetailsFailed({this.exception});

  @override
  List<Object?> get props => [exception];
}