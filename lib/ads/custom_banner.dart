import 'dart:async';

import 'package:ruvv/ads/ads.dart';
import 'package:ruvv/log.dart';
import 'package:flutter/cupertino.dart';

class CustomBanner extends StatefulWidget {
  final Ads ads;
  const CustomBanner({Key? key, required this.ads}) : super(key: key);

  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  @override
  void initState() {
    widget.ads.loadBannerAd(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    widget.ads.disposeBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.ads.isBannerAdReady) return Container();
    Log.log("Banner is visible");
    return widget.ads.getBannerAdWidget();
  }
}
