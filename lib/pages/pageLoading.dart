// ignore_for_file: unnecessary_this, file_names, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ruvv/ads/admob.dart';
import 'package:ruvv/ads/ads.dart';
import 'package:ruvv/ads/ads_data.dart';
import 'package:ruvv/ads/iron_source.dart';
import 'package:ruvv/ads/no_ads.dart';
import 'package:ruvv/constants.dart';
import 'package:ruvv/pages/pagePlay.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PageLoading extends StatefulWidget {
  @override
  _PageLoadingState createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {
  var ads;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAdsData();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 8,
                    ),
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Loading ...",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchAdsData() async {
    initOneSignal();
    http.get(Uri.parse(Constants.json_config_url)).then((response) async {
      Map<String, dynamic> adsJson = json.decode(response.body);
      var adsData = AdsData.fromJson(adsJson);
      Ads ads = _getAdsObj(adsData);
      await ads.init();
      ads.loadInterstitialAd();
      setState(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PagePlay(ads: ads)));
      });
    }).catchError((e) {});
  }

  _getAdsObj(AdsData adsData) {
    if (adsData.isAdmob == "1") return AdmobAD(adsData);
    if (adsData.isAdmob == "0") return IronSourceAD(adsData);
    return NoAds(adsData);
  }

  Future<void> initOneSignal() async {
    //OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId("f9e01b7a-4623-49a4-b772-beca65535cb3");
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }
}
