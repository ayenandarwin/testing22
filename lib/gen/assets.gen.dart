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

  /// File path: assets/images/Audiobook-bro 1.png
  AssetGenImage get audiobookBro1 =>
      const AssetGenImage('assets/images/Audiobook-bro 1.png');

  /// File path: assets/images/Dictionary-amico 1.png
  AssetGenImage get dictionaryAmico1 =>
      const AssetGenImage('assets/images/Dictionary-amico 1.png');

  /// File path: assets/images/Mypages.png
  AssetGenImage get mypages => const AssetGenImage('assets/images/Mypages.png');

  /// File path: assets/images/Thesis-pana 1.png
  AssetGenImage get thesisPana1 =>
      const AssetGenImage('assets/images/Thesis-pana 1.png');

  /// File path: assets/images/Video upload-rafiki 1.png
  AssetGenImage get videoUploadRafiki1 =>
      const AssetGenImage('assets/images/Video upload-rafiki 1.png');

  /// File path: assets/images/book-open.png
  AssetGenImage get bookOpen =>
      const AssetGenImage('assets/images/book-open.png');

  /// File path: assets/images/book1.png
  AssetGenImage get book1 => const AssetGenImage('assets/images/book1.png');

  /// File path: assets/images/book2.png
  AssetGenImage get book2 => const AssetGenImage('assets/images/book2.png');

  /// File path: assets/images/books.png
  AssetGenImage get books => const AssetGenImage('assets/images/books.png');

  /// File path: assets/images/morebooks.png
  AssetGenImage get morebooks =>
      const AssetGenImage('assets/images/morebooks.png');

  /// File path: assets/images/splashImageAudioBook.png
  AssetGenImage get splashImageAudioBook =>
      const AssetGenImage('assets/images/splashImageAudioBook.png');

  /// File path: assets/images/user.png
  AssetGenImage get user => const AssetGenImage('assets/images/user.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        audiobookBro1,
        dictionaryAmico1,
        mypages,
        thesisPana1,
        videoUploadRafiki1,
        bookOpen,
        book1,
        book2,
        books,
        morebooks,
        splashImageAudioBook,
        user
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
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

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
