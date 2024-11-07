import 'package:busha_app/data/models/local/coin_type.dart';
import 'package:busha_app/data/models/remote/block_transaction.dart';
import 'package:busha_app/data/models/remote/tezos_block_transaction.dart';
import 'package:busha_app/data/services/block_transaction_service.dart';

class FakeBlockTransactionService implements BlockTransactionService {

  @override
  Future<(BlockTransaction?, TezosBlockTransaction?)> fetchBlockByHash(String hash, CoinType coinType) async {
    return (BlockTransaction.forTest(), null);
  }

  @override
  Future<List<BlockTransaction>> fetchBtcBlockTransactions() async {
    return [BlockTransaction.forTest()];
  }

  @override
  Future<List<TezosBlockTransaction>> fetchTezosBlockTransactions() async {
    return [TezosBlockTransaction.forTest()];
  }
}
