part of 'crypto_list_bloc.dart';

abstract class CryptoListState extends Equatable {}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  final List<CryptoCoinModel> coin;

  CryptoListLoaded({required this.coin});

  @override
  List<Object?> get props => [coin];
}

class CryptoListLoadingFailure extends CryptoListState{
  final Object? exception;

  CryptoListLoadingFailure({this.exception});

  @override
  List<Object?> get props => [exception];
}