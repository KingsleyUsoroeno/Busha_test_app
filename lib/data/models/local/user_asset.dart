import 'package:busha_app/data/models/local/coin_type.dart';

class UserAsset {
  final CoinType coinType;
  final String currentPrice;
  final double currentMarketRoi;
  final bool isOnTheRise;

  UserAsset({
    required this.coinType,
    required this.currentPrice,
    required this.currentMarketRoi,
    required this.isOnTheRise,
  });
}

final currentUserAssets = <UserAsset>[
  UserAsset(
    coinType: CoinType.bitcoin,
    currentPrice: "₦24,500,00",
    currentMarketRoi: 1.76,
    isOnTheRise: false,
  ),
  UserAsset(
    coinType: CoinType.ethereum,
    currentPrice: "₦4,500",
    currentMarketRoi: 1.76,
    isOnTheRise: true,
  ),
  UserAsset(
    coinType: CoinType.tezos,
    currentMarketRoi: 9.06,
    currentPrice: "₦4,500",
    isOnTheRise: true,
  ),
];
