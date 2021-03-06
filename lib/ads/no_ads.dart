import 'package:ruvv/ads/ads.dart';
import 'package:ruvv/ads/ads_data.dart';
import 'package:flutter/material.dart';

class NoAds extends Ads {
  NoAds(AdsData adsData) : super(adsData);

  @override
  Future<void> init() async {}

  @override
  Future<void> loadBannerAd(_) async {}

  @override
  Future<void> loadInterstitialAd() async {}

  @override
  showInterstitialAd() {}

  @override
  bool get isBannerAdReady => false;

  @override
  bool get isInterstitialAdReady => false;

  @override
  Widget getBannerAdWidget() => Container();

  @override
  Future<void> disposeBanner() async {}

  @override
  Widget getNativeAdWidget() {
    return Container();
  }
}
