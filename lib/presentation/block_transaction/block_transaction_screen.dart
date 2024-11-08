import 'package:busha_app/data/models/local/coin_type.dart';
import 'package:busha_app/data/models/remote/block_transaction.dart';
import 'package:busha_app/data/models/remote/tezos_block_transaction.dart';
import 'package:busha_app/di/injection.dart';
import 'package:busha_app/gen/assets.gen.dart';
import 'package:busha_app/presentation/block_transaction/block_transaction_detail_screen.dart';
import 'package:busha_app/presentation/block_transaction/cubit/block_transaction_cubit.dart';
import 'package:busha_app/presentation/components/app_button.dart';
import 'package:busha_app/presentation/components/text_view.dart';
import 'package:busha_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockTransactionScreen extends StatefulWidget {
  final CoinType coinType;

  const BlockTransactionScreen({super.key, required this.coinType});

  @override
  State<BlockTransactionScreen> createState() => _BlockTransactionScreenState();
}

class _BlockTransactionScreenState extends State<BlockTransactionScreen> {
  final _cubit = getIt.get<BlockTransactionCubit>();

  @override
  void initState() {
    _cubit.fetchBlockTransactions(widget.coinType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppTheme.colorPrimary,
        leading: InkWell(
          child: Center(child: SvgPicture.asset(Assets.svg.icArrowBack, width: 20, height: 20)),
          onTap: () => Navigator.pop(context),
        ),
        title: TextView(text: "${widget.coinType.shortName} Transactions"),
        centerTitle: true,
      ),
      body: BlocBuilder<BlockTransactionCubit, BlockTransactionState>(
        bloc: _cubit,
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 18),
                TextView(
                  text: "Fetching your ${widget.coinType.shortName} transactions",
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                  color: Colors.black,
                )
              ],
            ),
            success: (List<BlockTransaction> transactions) {
              return ListView.separated(
                key: const Key("blockTransactionsListView"),
                padding: const EdgeInsets.only(left: 20, right: 16, top: 20),
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Divider(color: AppTheme.dividerGrey, thickness: 2.0),
                ),
                itemBuilder: (_, int index) {
                  final BlockTransaction transaction = transactions[index];
                  return _TransactionInfo(
                    key: Key(transaction.hash),
                    hash: transaction.hash,
                    date: transaction.date,
                    time: transaction.time,
                    coinType: CoinType.bitcoin,
                  );
                },
              );
            },
            fetchedTezosTransactions: (List<TezosBlockTransaction> transactions) {
              return ListView.separated(
                key: const Key("blockTransactionsListView"),
                padding: const EdgeInsets.only(left: 20, right: 16, top: 20),
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Divider(color: AppTheme.dividerGrey, thickness: 2.0),
                ),
                itemBuilder: (_, int index) {
                  final TezosBlockTransaction transaction = transactions[index];
                  return _TransactionInfo(
                    key: Key(transaction.hash),
                    hash: transaction.hash,
                    date: transaction.date,
                    time: transaction.time,
                    coinType: CoinType.tezos,
                  );
                },
              );
            },
            error: (String errorMessage) {
              return Center(
                key: const Key("transactionBlockErrorSection"),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextView(
                      text: errorMessage,
                      align: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppButton(
                        onPressed: () => _cubit.fetchBlockTransactions(widget.coinType),
                        title: "Try Again",
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TransactionInfo extends StatelessWidget {
  final String hash, date, time;
  final CoinType coinType;

  const _TransactionInfo({
    super.key,
    required this.hash,
    required this.date,
    required this.time,
    required this.coinType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlockTransactionDetailScreen(
              hash: hash,
              coinType: coinType,
            ),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: hash,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    TextView(
                      text: date,
                      color: Colors.black.withOpacity(0.50),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.56),
                        shape: BoxShape.circle,
                      ),
                    ),
                    TextView(
                      text: time,
                      color: Colors.black.withOpacity(0.50),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: SvgPicture.asset(Assets.svg.icChevronRight, width: 10),
          )
        ],
      ),
    );
  }
}
