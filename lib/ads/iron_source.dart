import 'package:ruvv/ads/ads.dart';
import 'package:ruvv/ads/ads_data.dart';
import 'package:ruvv/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:flutter_ironsource_x/models.dart';

class IronSourceAD extends Ads with IronSourceListener {
  IronSourceBannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  bool _isInterstitialAdReady = false;

  IronSourceAD(AdsData adsData) : super(adsData);

  @override
  bool get isBannerAdReady => _isBannerAdReady;

  @override
  bool get isInterstitialAdReady => _isInterstitialAdReady;

  // init
  @override
  Future<void> init() async {
    var userId = await IronSource.getAdvertiserId();
    await IronSource.validateIntegration();
    await IronSource.setUserId(userId);
    return IronSource.initialize(
      appKey: adsData.appkey,
      gdprConsent: true,
      ccpaConsent: false,
      listener: this,
    );
  }

  // Banner
  @override
  Future<void> loadBannerAd(_) async {
    _bannerAd = IronSourceBannerAd(
      keepAlive: false,
      listener: IronSourceBannerAdListener(onBannerLoaded: () {
        _isBannerAdReady = true;
        Log.log("onBannerLoaded");
      }, onBannerLoadFailed: (err) {
        _isBannerAdReady = false;
        Log.log("onBannerLoadFailed");
      }),
      size: BannerSize.LARGE,
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget getBannerAdWidget() {
    if (!_isBannerAdReady) return Container();
    return _bannerAd ?? Container();
  }

  @override
  Future<void> disposeBanner() async {}

  // Interstitial
  @override
  Future<void> loadInterstitialAd() async {
    return IronSource.loadInterstitial();
  }

  @override
  void showInterstitialAd() async {
    if ((await IronSource.isInterstitialReady()))
      IronSource.showInterstitial();
    else {
      Log.log(
        "Interstial is not ready. use 'Ironsource.loadInterstial' before showing it",
      );
    }
  }

  @override
  void onInterstitialAdClosed() {
    Log.log("onInterstitialAdClosed");
    loadInterstitialAd();
  }

  @override
  void onInterstitialAdLoadFailed(IronSourceError error) {
    Log.log("onInterstitialAdLoadFailed");
    loadInterstitialAd();
  }

  @override
  void onInterstitialAdReady() {
    Log.log("onInterstitialAdReady");
  }

  @override
  void onInterstitialAdShowFailed(IronSourceError error) {
    Log.log("onInterstitialAdShowFailed ${error.toString()}");
    loadInterstitialAd();
  }

  // native
  @override
  Widget getNativeAdWidget() {
    return Container();
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class IronSourceBannerAdListener extends IronSourceBannerListener {
  void Function()? onBannerLoaded;

  void Function(Map<String, dynamic>)? onBannerLoadFailed;

  IronSourceBannerAdListener({this.onBannerLoadFailed, this.onBannerLoaded});

  @override
  void onBannerAdLoadFailed(Map<String, dynamic> error) {
    this.onBannerLoadFailed!(error);
  }

  @override
  void onBannerAdLoaded() {
    this.onBannerLoaded!();
  }

  @override
  void onBannerAdClicked() {}

  @override
  void onBannerAdLeftApplication() {}

  @override
  void onBannerAdScreenDismissed() {}

  @override
  void onBannerAdScreenPresented() {}
}
