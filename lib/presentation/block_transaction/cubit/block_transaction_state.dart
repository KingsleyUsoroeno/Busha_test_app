part of 'block_transaction_cubit.dart';

@freezed
class BlockTransactionState with _$BlockTransactionState {
  const factory BlockTransactionState.initial() = _Initial;

  const factory BlockTransactionState.loading() = _Loading;

  const factory BlockTransactionState.success(List<BlockTransaction> blockTransactions) = _Success;

  const factory BlockTransactionState.fetchedTezosTransactions(List<TezosBlockTransaction> transactions) =
      _FetchedTezosTransactions;

  const factory BlockTransactionState.fetchedBlockInfo(
    BlockTransaction? blockTransaction,
    TezosBlockTransaction? tezosTransaction,
  ) = _FetchedBlockInfo;

  const factory BlockTransactionState.error(String errorMessage) = _Error;
}
