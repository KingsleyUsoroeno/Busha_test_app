import 'package:bloc/bloc.dart';
import 'package:busha_app/core/app_exception.dart';
import 'package:busha_app/core/app_logger.dart';
import 'package:busha_app/data/models/local/coin_type.dart';
import 'package:busha_app/data/models/remote/block_transaction.dart';
import 'package:busha_app/data/models/remote/tezos_block_transaction.dart';
import 'package:busha_app/data/services/block_transaction_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'block_transaction_cubit.freezed.dart';
part 'block_transaction_state.dart';

@Injectable()
class BlockTransactionCubit extends Cubit<BlockTransactionState> {
  final BlockTransactionService _blockTransactionService;

  BlockTransactionCubit(this._blockTransactionService) : super(const BlockTransactionState.initial());

  Future<void> fetchBlockTransactions(CoinType coinType) async {
    emit(const BlockTransactionState.loading());
    try {
      if (coinType == CoinType.tezos) {
        final List<TezosBlockTransaction> tezosTransactions =
            await _blockTransactionService.fetchTezosBlockTransactions();
        emit(BlockTransactionState.fetchedTezosTransactions(tezosTransactions));
      } else {
        final List<BlockTransaction> blockTransactions = await _blockTransactionService.fetchBtcBlockTransactions();
        emit(BlockTransactionState.success(blockTransactions));
      }
    } on BushaAppException catch (exception, stackTrace) {
      AppLogger.error(exception, stackTrace);
      emit(BlockTransactionState.error(exception.errorMessage));
    } catch (exception, stackTrace) {
      AppLogger.error(exception, stackTrace);
      emit(const BlockTransactionState.error("Oops! something went wrong."));
    }
  }

  Future<void> fetchBlockTransactionInfo(String hash, CoinType coinType) async {
    emit(const BlockTransactionState.loading());
    try {
      final (btcBlockTransactionInfo, tezosTransactionInfo) =
          await _blockTransactionService.fetchBlockByHash(hash, coinType);
      emit(BlockTransactionState.fetchedBlockInfo(btcBlockTransactionInfo, tezosTransactionInfo));
    } on BushaAppException catch (exception, stackTrace) {
      AppLogger.error(exception, stackTrace);
      emit(BlockTransactionState.error(exception.errorMessage));
    } catch (exception, stackTrace) {
      AppLogger.error(exception, stackTrace);
      emit(const BlockTransactionState.error("Oops! something went wrong."));
    }
  }
}
