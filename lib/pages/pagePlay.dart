// ignore_for_file: avoid_unnecessary_containers, no_logic_in_create_state, file_names, import_of_legacy_library_into_null_safe, unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruvv/ads/ads.dart';
import 'package:ruvv/ads/custom_banner.dart';
import 'package:ruvv/pages/pageSelectMod.dart';
import 'package:ruvv/utils.dart';
import 'package:share/share.dart';

class PagePlay extends StatefulWidget {
  final Ads ads;
  PagePlay({required this.ads});
  @override
  _PagePlayState createState() => _PagePlayState();
}

class _PagePlayState extends State<PagePlay> {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  double h = 0.5;
  @override
  void initState() {
    count();
    palySound();
    widget.ads.loadInterstitialAd();
    super.initState();
  }

  void count() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (h == 0.5) {
          h = 0.4;
        } else {
          h = 0.5;
        }
      });
    });
  }

  palySound() {
    player.open(
      Audio("assets/pre.mp3"),
      loopMode: LoopMode.single,
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
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
            child: Column(
              children: [
                //SizedBox(height: 10),
                // CustomBanner(ads: widget.ads),
                widget.ads.getNativeAdWidget(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: _width,
                        height: _width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              width: _width * h,
                              image: AssetImage('assets/lg.png'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // width: _width * 2,
                        height: _width * 0.7,
                        child: Image(
                          image: AssetImage('assets/pre.gif'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20, bottom: 15),
                              child: IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.star,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Utils.openLink(
                                        url:
                                            'https://play.google.com/store/apps/details?id=com.fnfgameplayherror.musiclittlephoenihuggy');
                                  }),
                            ),
                            Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      height: 50,
                                      width: _width * 0.4,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 4.0,
                                                color: Colors.pinkAccent)
                                          ],
                                          color: Colors.pink,
                                          border: Border.all(
                                              width: 2, color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: InkWell(
                                        onTap: () {
                                          player.stop();
                                          widget.ads.showInterstitialAd();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PageSelectMod(
                                                        ads: widget.ads,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.play_arrow,
                                              size: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "PLAY",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                ])),
                            Container(
                              margin: EdgeInsets.only(left: 20, bottom: 15),
                              child: IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.share,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Share.share("""
                best App :
                http://play.google.com/store/apps/details?id=com.fnfgameplayherror.musiclittlephoenihuggy
                """);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
