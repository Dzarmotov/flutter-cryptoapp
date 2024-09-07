import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project_crypto/features/crypto_coin/bloc/crypto_coin_details_bloc.dart';
import 'package:project_crypto/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:project_crypto/repositories/models/crypto_coin.dart';

class CryptoCoinScreen extends StatefulWidget {
  final CryptoCoinModel? currencyCode;

  const CryptoCoinScreen({super.key, required this.currencyCode});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {

  final _cryptoCoinDetails = CryptoCoinDetailsBloc(GetIt.instance<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoCoinDetails.add(LoadCryptoDetail(currencyCode: widget.currencyCode!.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
        bloc: _cryptoCoinDetails,
        builder: (context, state) {
          if(state is CryptoCoinDetailsLoaded) {
            final coinDetails = state.coinDetail;
            final details = coinDetails.details;
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Image.network(details.fullImageUrl, width: 150, height: 150,),
                  const SizedBox(height: 20,),
                  Text(state.coinDetail.name),
                  const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10)
                    ),
                      width: 350,
                      height: 50,
                      child: Center(child: Text('${details.priceInUSD.toStringAsFixed(2)} \$', textAlign: TextAlign.center,))),
                  const SizedBox(height: 20,),
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Hight 24 Hour'),
                              Text('${details.hight24Hour.toStringAsFixed(2)} \$'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Low 24 Hour'),
                              Text('${details.low24Hours.toStringAsFixed(2)} \$'),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          if(state is CryptoCoinDetailsFailed) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Что-то пошло не так', style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('Повторите попытку позже', style: TextStyle(color: Colors.grey),),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }
}
