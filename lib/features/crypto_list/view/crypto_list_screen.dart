
import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_crypto/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:project_crypto/features/crypto_list/widgets/widgets.dart';
import 'package:project_crypto/repositories/crypto_coins/abstract_coins_repository.dart';

@RoutePage()
class CryptoListScreen extends StatefulWidget {

  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  final _cryptoListBloc = CryptoListBloc(GetIt.instance<AbstractCoinsRepository>());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cryptoListBloc.add(LoadCryptoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crypto',),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TalkerScreen(talker: GetIt.instance<Talker>())));
          }, icon: Icon(Icons.document_scanner_outlined))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if(state is CryptoListLoaded) {
              return ListView.separated(
                  separatorBuilder: (BuildContext context, int i) => const Divider(color: Colors.white24,),
                  itemCount: state.coin.length,
                  itemBuilder: (BuildContext context, int i) {
                  final coin = state.coin[i];
                  return CryptoCoinTile(coin: coin);
              });
            }
            if(state is CryptoListLoadingFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Проверьте подключение к интернету'),
                  const Text('И повторите попытку'),
                  const SizedBox(height: 30,),
                  TextButton(onPressed: () {
                    _cryptoListBloc.add(LoadCryptoList());
                  }, child: const Text('Повторить попытку'))
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      )
    );
  }
}
