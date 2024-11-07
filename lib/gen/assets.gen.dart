/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/image_elon_musk.png
  AssetGenImage get imageElonMusk =>
      const AssetGenImage('assets/images/image_elon_musk.png');

  /// File path: assets/images/img_bitcoin.png
  AssetGenImage get imgBitcoin =>
      const AssetGenImage('assets/images/img_bitcoin.png');

  /// File path: assets/images/img_ethereum.png
  AssetGenImage get imgEthereum =>
      const AssetGenImage('assets/images/img_ethereum.png');

  /// File path: assets/images/img_solana.png
  AssetGenImage get imgSolana =>
      const AssetGenImage('assets/images/img_solana.png');

  /// File path: assets/images/img_thezos.png
  AssetGenImage get imgThezos =>
      const AssetGenImage('assets/images/img_thezos.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [imageElonMusk, imgBitcoin, imgEthereum, imgSolana, imgThezos];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/ic-arrow-down-right-red.svg
  String get icArrowDownRightRed => 'assets/svg/ic-arrow-down-right-red.svg';

  /// File path: assets/svg/ic-arrow-up-right-green.svg
  String get icArrowUpRightGreen => 'assets/svg/ic-arrow-up-right-green.svg';

  /// File path: assets/svg/ic-chevron-right.svg
  String get icChevronRight => 'assets/svg/ic-chevron-right.svg';

  /// File path: assets/svg/ic_arrow_back.svg
  String get icArrowBack => 'assets/svg/ic_arrow_back.svg';

  /// File path: assets/svg/ic_connect.svg
  String get icConnect => 'assets/svg/ic_connect.svg';

  /// File path: assets/svg/ic_explorer.svg
  String get icExplorer => 'assets/svg/ic_explorer.svg';

  /// File path: assets/svg/ic_notification.svg
  String get icNotification => 'assets/svg/ic_notification.svg';

  /// File path: assets/svg/ic_percent_outline.svg
  String get icPercentOutline => 'assets/svg/ic_percent_outline.svg';

  /// File path: assets/svg/ic_scan.svg
  String get icScan => 'assets/svg/ic_scan.svg';

  /// File path: assets/svg/ic_search.svg
  String get icSearch => 'assets/svg/ic_search.svg';

  /// File path: assets/svg/ic_solana.svg
  String get icSolana => 'assets/svg/ic_solana.svg';

  /// File path: assets/svg/ic_spend_outline.svg
  String get icSpendOutline => 'assets/svg/ic_spend_outline.svg';

  /// File path: assets/svg/ic_wallet_outlined.svg
  String get icWalletOutlined => 'assets/svg/ic_wallet_outlined.svg';

  /// List of all assets
  List<String> get values => [
        icArrowDownRightRed,
        icArrowUpRightGreen,
        icChevronRight,
        icArrowBack,
        icConnect,
        icExplorer,
        icNotification,
        icPercentOutline,
        icScan,
        icSearch,
        icSolana,
        icSpendOutline,
        icWalletOutlined
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
