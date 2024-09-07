import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_crypto/features/crypto_coin/view/crypto_coin.dart';
import 'package:project_crypto/repositories/models/crypto_coin.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoinModel coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final coinDetails = coin.details;
    return ListTile(
      leading: Image.network(coinDetails.fullImageUrl),
      title: Text(coin.name, style: theme.bodyMedium,),
      subtitle: Text('${coinDetails.priceInUSD} \$', style: theme.labelSmall,),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CryptoCoinScreen(currencyCode: coin,)));
      },
    );
  }
}