import 'package:busha_app/gen/assets.gen.dart';

class NewsInfo {
  final String imageUrl;
  final String newsTitle;
  final String newsPublisher;
  final String timeAgo;

  NewsInfo({
    required this.imageUrl,
    required this.newsTitle,
    required this.newsPublisher,
    required this.timeAgo,
  });
}

class NewsInfoWrapper {
  final NewsInfo newsHeading;
  final List<NewsInfo> newsSubInfo;

  NewsInfoWrapper({required this.newsHeading, required this.newsSubInfo});
}

final _newsInfo = List.generate(
  4,
  (_) {
    return NewsInfo(
      imageUrl: Assets.images.imageElonMusk.path,
      newsTitle: "Ethereum Co-founder opposes El-salvador Bitcoin Adoption policy",
      newsPublisher: "CoinDesk",
      timeAgo: "2h",
    );
  },
);

final newsInfoWrapper = NewsInfoWrapper(newsHeading: _newsInfo[0], newsSubInfo: _newsInfo);
