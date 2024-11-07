import 'package:busha_app/data/models/local/coin_type.dart';
import 'package:busha_app/di/injection.dart';
import 'package:busha_app/gen/assets.gen.dart';
import 'package:busha_app/presentation/block_transaction/cubit/block_transaction_cubit.dart';
import 'package:busha_app/presentation/shared/components/text_view.dart';
import 'package:busha_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlockTransactionDetailScreen extends StatefulWidget {
  final String hash;
  final CoinType coinType;

  const BlockTransactionDetailScreen({super.key, required this.hash, required this.coinType});

  @override
  State<BlockTransactionDetailScreen> createState() => _BlockTransactionDetailScreenState();
}

class _BlockTransactionDetailScreenState extends State<BlockTransactionDetailScreen> {
  final _cubit = getIt.get<BlockTransactionCubit>();

  @override
  void initState() {
    _cubit.fetchBlockTransactionInfo(widget.hash, widget.coinType);
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
        title: const TextView(text: "Transaction details"),
        centerTitle: true,
      ),
      body: BlocBuilder<BlockTransactionCubit, BlockTransactionState>(
        bloc: _cubit,
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            fetchedBlockInfo: (btcTransaction, tezosTransaction) {
              return Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    _RowTextWidget(
                      title: "Hash",
                      desc: btcTransaction?.hash ?? tezosTransaction?.hash ?? "",
                      child: Flexible(
                        child: TextView(
                          text: btcTransaction?.hash ?? tezosTransaction?.hash ?? "",
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.95),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      child: Divider(
                        color: AppTheme.dividerGrey,
                        thickness: 1.0,
                      ),
                    ),
                    _RowTextWidget(
                      title: "Time",
                      desc: "",
                      child: Row(
                        children: [
                          TextView(
                            text: btcTransaction?.date ?? tezosTransaction?.date ?? "",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.95),
                          ),
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                          ),
                          TextView(
                            text: btcTransaction?.time ?? tezosTransaction?.time ?? "",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.95),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      child: Divider(color: AppTheme.dividerGrey, thickness: 1.0),
                    ),
                    if (btcTransaction != null)
                      _RowTextWidget(
                        title: "Size",
                        desc: btcTransaction.size.toString(),
                      )
                    else
                      _RowTextWidget(
                        title: "Level",
                        desc: tezosTransaction!.level.toString(),
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      child: Divider(color: AppTheme.dividerGrey, thickness: 1.0),
                    ),
                    if (btcTransaction != null)
                      _RowTextWidget(
                        title: "Block Index",
                        desc: btcTransaction.blockIndex.toString(),
                      )
                    else
                      _RowTextWidget(
                        title: "Reward",
                        desc: tezosTransaction!.reward.toString(),
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      child: Divider(color: AppTheme.dividerGrey, thickness: 1.0),
                    ),
                    if (btcTransaction != null)
                      _RowTextWidget(
                        title: "Height",
                        desc: btcTransaction.blockHeight.toString(),
                      )
                    else
                      _RowTextWidget(
                        title: "Bonus",
                        desc: tezosTransaction!.bonus.toString(),
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      child: Divider(color: AppTheme.dividerGrey, thickness: 1.0),
                    ),
                    if (btcTransaction != null)
                      _RowTextWidget(
                        title: "Received time",
                        desc: "",
                        child: Row(
                          children: [
                            TextView(
                              text: btcTransaction.date,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.95),
                            ),
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            ),
                            TextView(
                              text: btcTransaction.time,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.95),
                            ),
                          ],
                        ),
                      )
                    else
                      _RowTextWidget(
                        title: "Fees",
                        desc: tezosTransaction!.fees.toString(),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.svg.icExplorer),
                              const SizedBox(width: 14.0),
                              TextView(
                                text: "View on blockchain explorer",
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.95),
                              ),
                            ],
                          ),
                          SvgPicture.asset(Assets.svg.icChevronRight, width: 12),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            error: (String errorMessage) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextView(text: errorMessage),
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

class _RowTextWidget extends StatelessWidget {
  final String title;
  final String desc;
  final Widget? child;

  const _RowTextWidget({
    super.key,
    required this.title,
    required this.desc,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 16),
      child: Row(
        children: [
          TextView(
            text: title,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.black.withOpacity(0.60),
          ),
          const Spacer(),
          child ??
              TextView(
                text: desc,
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Colors.black.withOpacity(0.95),
              )
        ],
      ),
    );
  }
}
