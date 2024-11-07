import 'package:busha_app/core/network/dio_helper.dart';
import 'package:busha_app/data/models/local/coin_type.dart';
import 'package:busha_app/data/models/remote/block_transaction.dart';
import 'package:busha_app/data/models/remote/tezos_block_transaction.dart';
import 'package:busha_app/core/app_logger.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class BlockTransactionService {
  final DioClientWrapper _dioClient;

  BlockTransactionService(this._dioClient);

  Future<List<BlockTransaction>> fetchBtcBlockTransactions() async {
    _dioClient.changeBaseUrl("https://blockchain.info/");
    final latestBlockResponse = await _dioClient.get("latestblock");
    final String hash = latestBlockResponse.data['hash'];

    AppLogger.debug("latest block hash is $hash");

    final response = await _dioClient.get("rawblock/$hash");
    return List.from(response.data['tx']).map((e) => BlockTransaction.fromJson(e)).toList();
  }

  Future<List<TezosBlockTransaction>> fetchTezosBlockTransactions() async {
    _dioClient.changeBaseUrl("https://api.tzkt.io/");
    final response = await _dioClient.get("v1/blocks");
    return List.from(response.data).map((e) => TezosBlockTransaction.fromJson(e)).toList();
  }

  Future<(BlockTransaction?, TezosBlockTransaction?)> fetchBlockByHash(String hash, CoinType coinType) async {
    if (coinType == CoinType.tezos) {
      _dioClient.changeBaseUrl("https://api.tzkt.io/");
      final response = await _dioClient.get("v1/blocks/$hash");
      return (null, TezosBlockTransaction.fromJson(response.data));
    } else {
      _dioClient.changeBaseUrl("https://blockchain.info/");
      AppLogger.debug("hash is $hash");
      final response = await _dioClient.get("rawtx/$hash");
      return (BlockTransaction.fromJson(response.data), null);
    }
  }
}
