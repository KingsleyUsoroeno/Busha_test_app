import 'package:busha_app/data/models/local/coin_type.dart';
import 'package:busha_app/data/models/local/user_asset.dart';
import 'package:busha_app/gen/assets.gen.dart';
import 'package:busha_app/presentation/components/text_view.dart';
import 'package:busha_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAssetItem extends StatelessWidget {
  final UserAsset userAsset;
  final Function(CoinType) onTap;

  const MyAssetItem({super.key, required this.userAsset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call(userAsset.coinType);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(userAsset.coinType.coinImage)),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: userAsset.coinType.coinName,
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  TextView(
                    text: userAsset.coinType.shortName,
                    color: Colors.black.withOpacity(0.60),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextView(
                text: userAsset.currentPrice,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              Row(
                children: [
                  if (userAsset.isOnTheRise)
                    SvgPicture.asset(Assets.svg.icArrowUpRightGreen)
                  else
                    SvgPicture.asset(Assets.svg.icArrowDownRightRed),
                  TextView(
                    text: "${userAsset.currentMarketRoi}%",
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: userAsset.isOnTheRise ? AppTheme.colorAccent : Colors.red,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}