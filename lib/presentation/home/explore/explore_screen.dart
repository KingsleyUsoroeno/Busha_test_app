import 'package:busha_app/data/models/local/coin_type.dart';
import 'package:busha_app/data/models/local/current_top_mover.dart';
import 'package:busha_app/data/models/local/news_info.dart';
import 'package:busha_app/data/models/local/user_asset.dart';
import 'package:busha_app/gen/assets.gen.dart';
import 'package:busha_app/presentation/block_transaction/block_transaction_screen.dart';
import 'package:busha_app/presentation/home/explore/components/my_asset_item.dart';
import 'package:busha_app/presentation/shared/components/text_view.dart';
import 'package:busha_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/news_info_ui.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool _obscureBalance = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 12.0, top: 28),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Assets.svg.icScan),
                const Expanded(
                  child: Center(
                    child: TextView(
                      text: "Explore",
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.svg.icSearch),
                    const SizedBox(width: 12),
                    SvgPicture.asset(Assets.svg.icNotification),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                TextView(
                  text: "My Balance",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.60),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () {
                    setState(() {
                      _obscureBalance = !_obscureBalance;
                    });
                  },
                  child: Icon(
                    _obscureBalance ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black.withOpacity(0.60),
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextView(
                    text: "₦",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextView(
                  text: _obscureBalance ? "*" * 5 : "5,000.00",
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              color: AppTheme.dividerGrey,
              thickness: 2.0,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(left: 18.0, right: 12.0),
            child: _RowTextWidget(
              key: Key("MyAssetsRowTextWidget"),
              title: "My Assets",
              subTitle: "See all",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 12.0, top: 10),
            child: Column(
              children: [
                for (int i = 0; i < currentUserAssets.length; i++) ...[
                  MyAssetItem(
                    key: Key(currentUserAssets[i].coinType.name),
                    userAsset: currentUserAssets[i],
                    onTap: (CoinType coinType) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlockTransactionScreen(coinType: coinType),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14.0),
                ]
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              color: AppTheme.dividerGrey,
              thickness: 2.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18.0, right: 12.0, top: 14),
            child: _RowTextWidget(
              key: Key("TopMoviesRowTextWidget"),
              title: "Today's Top Movers",
              subTitle: "See all",
            ),
          ),
          SizedBox(
            height: 130,
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 12.0, left: 18.0, right: 12.0),
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, int index) {
                final CurrentTopMover topMover = currentTopMovers[index];
                return _TopMoverItem(
                  key: Key(topMover.coinType.name),
                  topMover: topMover,
                  onTap: (coinType) {},
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              color: AppTheme.dividerGrey,
              thickness: 2.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18.0, right: 12.0, top: 20),
            child: _RowTextWidget(
              key: Key("TrendingNewsRowTextWidget"),
              title: "Trending news",
              subTitle: "View more",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 12, left: 18.0),
            child: NewsInfoUi(
              newsInfoWrapper: newsInfoWrapper,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopMoverItem extends StatelessWidget {
  final CurrentTopMover topMover;
  final Function(CoinType) onTap;

  const _TopMoverItem({super.key, required this.topMover, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.12)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          onTap.call(topMover.coinType);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(topMover.coinType.coinImage, width: 40, height: 40),
              const SizedBox(height: 4.0),
              TextView(
                text: topMover.coinType.coinName,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  SvgPicture.asset(
                    topMover.isOnTheRise ? Assets.svg.icArrowUpRightGreen : Assets.svg.icArrowDownRightRed,
                  ),
                  TextView(
                    text: "${topMover.currentMarketRoi}%",
                    color: topMover.isOnTheRise ? AppTheme.colorAccent : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _RowTextWidget extends StatelessWidget {
  final String title, subTitle;

  const _RowTextWidget({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(
          text: title,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        TextView(
          text: subTitle,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: AppTheme.colorAccent,
        ),
      ],
    );
  }
}
