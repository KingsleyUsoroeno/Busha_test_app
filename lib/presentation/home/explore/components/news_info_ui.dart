import 'package:busha_app/data/models/local/news_info.dart';
import 'package:busha_app/presentation/components/text_view.dart';
import 'package:busha_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class NewsInfoUi extends StatelessWidget {
  final NewsInfoWrapper newsInfoWrapper;

  const NewsInfoUi({super.key, required this.newsInfoWrapper});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 166,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(image: AssetImage(newsInfoWrapper.newsHeading.imageUrl), fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextView(
            text: newsInfoWrapper.newsHeading.newsTitle,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              TextView(
                text: newsInfoWrapper.newsHeading.newsPublisher,
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: AppTheme.grayBlue,
              ),
              const SizedBox(width: 4),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppTheme.grayBlue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              TextView(
                text: newsInfoWrapper.newsHeading.timeAgo,
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: AppTheme.grayBlue,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        for (int i = 0; i < newsInfoWrapper.newsSubInfo.length; i++) ...[
          Row(
            children: [
              Container(
                height: 77,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                      image: AssetImage(newsInfoWrapper.newsSubInfo[i].imageUrl),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(width: 14),
              Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextView(
                        text: newsInfoWrapper.newsSubInfo[i].newsTitle,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          TextView(
                            text: newsInfoWrapper.newsHeading.newsPublisher,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                            color: AppTheme.grayBlue,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: AppTheme.grayBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          TextView(
                            text: newsInfoWrapper.newsHeading.timeAgo,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                            color: AppTheme.grayBlue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              color: AppTheme.dividerGrey,
              thickness: 1.0,
            ),
          ),
        ]
      ],
    );
  }
}