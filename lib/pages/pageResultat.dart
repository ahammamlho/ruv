// ignore_for_file: avoid_unnecessary_containers, no_logic_in_create_state, file_names, import_of_legacy_library_into_null_safe, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ruvv/ads/ads.dart';
import 'package:ruvv/ads/custom_banner.dart';
import 'package:ruvv/pages/pageLoading.dart';
import 'package:ruvv/pages/pagePlay.dart';
import 'package:ruvv/utils.dart';

class PageResultat extends StatefulWidget {
  final String music;
  final Ads ads;
  PageResultat({required this.music, required this.ads});

  @override
  _PageResultatState createState() => _PageResultatState(music);
}

class _PageResultatState extends State<PageResultat> {
  String music;
  _PageResultatState(this.music);
  String img = "assets/pre.gif";
  Color cl1 = Colors.pink;
  Color cl2 = Colors.blue;
  Color cl3 = Colors.green;
  Color cl4 = Colors.red;
  AssetsAudioPlayer player = AssetsAudioPlayer();
  AssetsAudioPlayer pipp = AssetsAudioPlayer();
  int score = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    palySound();

    tiktok();
  }

  int t = 0;
  int y = 0;
  String c = "0";
  String c2 = "0";
  void tiktok() {
    Timer _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (t < 10) c2 = "0";
        if (t > 10) c2 = "";
        t++;
        if (t == 60) {
          t = 0;
          y++;
        }
      });
    });
  }

  void count() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        img = "assets/pre.gif";
        cl1 = Colors.pink;
        cl2 = Colors.blue;
        cl3 = Colors.green;
        cl4 = Colors.red;
        d1 = 60;
        d2 = 60;
        d3 = 60;
        d4 = 60;
      });
    });
  }

  pip() {
    setState(() {
      score++;
    });
    pipp.open(
      Audio("assets/pip.mp3"),
      volume: 1,
    );
  }

  palySound() {
    if (music == "NORMAL") {
      player.open(
        Audio("assets/normal.mp3"),
        loopMode: LoopMode.single,
        volume: 0.8,
      );
    } else if (music == " SUPER") {
      player.open(
        Audio("assets/super.mp3"),
        loopMode: LoopMode.single,
        volume: 0.8,
      );
    }
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
                SizedBox(height: 10),
                CustomBanner(ads: widget.ads),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("$c$y : $c2$t",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                      Container(
                        margin: EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.home,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  widget.ads.showInterstitialAd();
                                  player.stop();
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => PagePlay(
                                                ads: widget.ads,
                                              )));
                                }),
                            IconButton(
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
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        //  height: 50,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black,
                                  offset: Offset(1, 1))
                            ]),
                        child: Text("SCORE : $score",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                      Container(
                        width: _width,
                        height: _width * 0.6,
                        margin: EdgeInsets.only(top: 40, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image(
                                image: AssetImage(img),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 30),
                          buttonPlay(
                              "left", FontAwesomeIcons.arrowLeft, cl1, d1),
                          buttonPlay(
                              "down", FontAwesomeIcons.arrowDown, cl2, d2),
                          buttonPlay("up", FontAwesomeIcons.arrowUp, cl3, d3),
                          buttonPlay(
                              "right", FontAwesomeIcons.arrowRight, cl4, d4),
                          SizedBox(width: 30),
                        ],
                      ),
                      SizedBox(height: 20),
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

  double d1 = 60;
  double d2 = 60;
  double d3 = 60;
  double d4 = 60;
  int i = 0;
  Widget buttonPlay(String mod, IconData icon, Color cl, double d) {
    return InkWell(
      onLongPress: () {
        setState(() {
          // count();
          pip();

          switch (mod) {
            case "left":
              {
                d1 = 70;
                cl1 = Colors.white;
                img = "assets/left.gif";
              }
              break;

            case "right":
              {
                d4 = 70;
                img = "assets/right.gif";
                cl4 = Colors.white;
              }
              break;
            case "up":
              {
                d3 = 70;
                img = "assets/up.gif";
                cl3 = Colors.white;
              }
              break;
            case "down":
              {
                d2 = 70;
                img = "assets/down.gif";
                cl2 = Colors.white;
              }
              break;
          }
        });
      },
      onTap: () {
        setState(() {
          count();
          pip();
          switch (mod) {
            case "left":
              {
                d1 = 70;
                cl1 = Colors.white;
                img = "assets/left.gif";
              }
              break;

            case "right":
              {
                d4 = 70;
                img = "assets/right.gif";
                cl4 = Colors.white;
              }
              break;
            case "up":
              {
                d3 = 70;
                img = "assets/up.gif";
                cl3 = Colors.white;
              }
              break;
            case "down":
              {
                d2 = 70;
                img = "assets/down.gif";
                cl2 = Colors.white;
              }
              break;
          }
        });
      },
      child: Container(
        alignment: Alignment(0, 0),
        height: d,
        width: d,
        decoration: BoxDecoration(
            border: Border.all(width: 8, color: cl),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: FaIcon(
          icon,
          size: 40,
          color: cl,
        ),
      ),
    );
  }
}
