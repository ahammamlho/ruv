import 'package:ruvv/ads/ads.dart';
import 'package:ruvv/ads/ads_data.dart';
import 'package:ruvv/log.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart' as native_admob;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobAD extends Ads {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int _numBannerLoadAttempts = 0;
  int _maxAttempts = 5;

  AdmobAD(AdsData adsData) : super(adsData);

  @override
  bool get isBannerAdReady => _bannerAd != null;
  @override
  bool get isInterstitialAdReady => _interstitialAd != null;

  // init
  @override
  Future<InitializationStatus> init() async {
    await native_admob.MobileAds.initialize();
    return MobileAds.instance.initialize();
  }

  // Banner
  @override
  loadBannerAd(onLoaded) {
    _bannerAd = BannerAd(
      adUnitId: adsData.idBanner,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(onAdLoaded: (_) {
        Log.log('banner ad loaded');
        _numBannerLoadAttempts = 0;
        onLoaded!();
      }, onAdFailedToLoad: (ad, err) {
        Log.log('Failed to load banner ad: ${err.message}');
        ad.dispose();
        _bannerAd = null;
        _numBannerLoadAttempts += 1;
        if (_numBannerLoadAttempts <= _maxAttempts) loadBannerAd(onLoaded);
      }),
    );
    return _bannerAd!.load();
  }

  @override
  Widget getBannerAdWidget() {
    if (_bannerAd == null) return Container();
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: _bannerAd?.size.width.toDouble(),
        height: _bannerAd?.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }

  @override
  Future<void> disposeBanner() async {
    await _bannerAd?.dispose();
    _bannerAd = null;
  }

  // Interstitial
  @override
  Future<void> loadInterstitialAd() {
    return InterstitialAd.load(
      adUnitId: adsData.idInter,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        Log.log('$ad loaded');
        this._interstitialAd = ad;
        _numInterstitialLoadAttempts = 0;
      }, onAdFailedToLoad: (err) {
        Log.log('Failed to load interstitial ad: ${err.message}');
        _numInterstitialLoadAttempts += 1;
        _interstitialAd = null;
        if (_numInterstitialLoadAttempts <= _maxAttempts) loadInterstitialAd();
      }),
    );
  }

  @override
  void showInterstitialAd() {
    if (_interstitialAd == null) {
      Log.log("Warning: attempt to show interstitial before loaded.");
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) =>
            Log.log('$ad onAdShowedFullScreenContent'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          Log.log('$ad onAdDismissedFullScreenContent');
          ad.dispose();
          loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          Log.log('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          loadInterstitialAd();
        });
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  // Native Ad
  @override
  Widget getNativeAdWidget() {
    return native_admob.NativeAd(
      height: 300,
      buildLayout: native_admob.mediumAdTemplateLayoutBuilder,
      loading: Container(),
      error: Container(),
      unitId: adsData.idNative,
    );
  }
}
