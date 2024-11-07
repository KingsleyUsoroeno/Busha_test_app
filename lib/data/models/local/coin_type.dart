import 'package:busha_app/gen/assets.gen.dart';

enum CoinType {
  bitcoin,
  ethereum,
  solana,
  tezos;

  String get coinName {
    switch (this) {
      case CoinType.bitcoin:
        return "BitCoin";

      case CoinType.ethereum:
        return "Ethereum";

      case CoinType.solana:
        return "Solana";

      case CoinType.tezos:
        return "Tezos";

      default:
        return "";
    }
  }

  String get shortName {
    switch (this) {
      case CoinType.bitcoin:
        return "BTC";

      case CoinType.ethereum:
        return "ETH";

      case CoinType.solana:
        return "SOL";

      case CoinType.tezos:
        return "XTZ";

      default:
        return "";
    }
  }

  String get coinImage {
    switch (this) {
      case CoinType.bitcoin:
        return Assets.images.imgBitcoin.path;

      case CoinType.ethereum:
        return Assets.images.imgEthereum.path;

      case CoinType.tezos:
        return Assets.images.imgThezos.path;

      case CoinType.solana:
        return Assets.images.imgSolana.path;

      default:
        return "";
    }
  }
}
