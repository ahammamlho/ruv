// ignore_for_file: unused_element, prefer_const_constructors

import 'package:ruvv/ads/ads_data.dart';
import 'package:flutter/material.dart';

abstract class Ads {
  late final AdsData adsData;
  Ads(this.adsData);

  bool get isInterstitialAdReady;
  bool get isBannerAdReady;

  Future<void> loadBannerAd(Function? onLoaded);
  Widget getBannerAdWidget();
  Future<void> disposeBanner();

  Future<void> loadInterstitialAd();
  void showInterstitialAd();

  Widget getNativeAdWidget();

  Future<void> init();
}
