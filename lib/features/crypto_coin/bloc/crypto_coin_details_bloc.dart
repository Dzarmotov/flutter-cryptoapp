import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:project_crypto/repositories/models/models.dart';

part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

class CryptoCoinDetailsBloc extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc(this.coinsRepository) : super(CryptoCoinDetailsInitial()) {
    on<LoadCryptoDetail>((event, emit) async{
      try{
        final coinDetails = await coinsRepository.getCoinDetails(event.currencyCode);
        emit(CryptoCoinDetailsLoaded(coinDetail: coinDetails));
      } catch(e, st) {
        emit(CryptoCoinDetailsFailed(exception: e));
        GetIt.instance<Talker>().handle(e, st);
      }
    });
  }

  final AbstractCoinsRepository coinsRepository;

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);

  }
}
