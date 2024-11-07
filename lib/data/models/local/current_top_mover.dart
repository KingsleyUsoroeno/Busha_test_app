import 'package:busha_app/data/models/local/coin_type.dart';

class CurrentTopMover {
  final CoinType coinType;
  final double currentMarketRoi;
  final bool isOnTheRise;

  CurrentTopMover({
    required this.coinType,
    required this.currentMarketRoi,
    required this.isOnTheRise,
  });
}

final currentTopMovers = <CurrentTopMover>[
  CurrentTopMover(
    coinType: CoinType.ethereum,
    currentMarketRoi: 1.76,
    isOnTheRise: false,
  ),
  CurrentTopMover(
    coinType: CoinType.bitcoin,
    currentMarketRoi: 1.76,
    isOnTheRise: true,
  ),
  CurrentTopMover(
    coinType: CoinType.solana,
    currentMarketRoi: 1.76,
    isOnTheRise: true,
  ),
];
