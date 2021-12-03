// ignore_for_file: avoid_unnecessary_containers, no_logic_in_create_state, file_names, import_of_legacy_library_into_null_safe, prefer_const_constructors

import 'dart:async';
import 'package:ruvv/ads/ads.dart';
import 'package:ruvv/ads/custom_banner.dart';
import 'package:ruvv/pages/pageResultat.dart';
import 'package:ruvv/utils.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageSelectMod extends StatefulWidget {
  final Ads ads;
  PageSelectMod({required this.ads});
  @override
  _PageSelectModState createState() => _PageSelectModState(ads);
}

class _PageSelectModState extends State<PageSelectMod> {
  var ads;
  _PageSelectModState(this.ads);

  double h = 45;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count();
  }

  void count() {
    Timer _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (h == 45) {
          h = 50;
        } else {
          h = 45;
        }
      });
    });
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(top: 0),
                        child: Text(
                          "Select Mod",
                          style: TextStyle(
                            fontSize: h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Column(
                            children: [
                              buttonMod(" EASY "),
                              SizedBox(height: 15),
                              buttonMod("NORMAL"),
                              SizedBox(height: 15),
                              buttonMod(" SUPER"),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20, bottom: 15),
                                child: Column(
                                  children: [
                                    IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.star,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Utils.openLink(
                                              url:
                                                  'http://play.google.com/store/apps/details?id=com.fnfgameplayherror.musiclittlephoenihuggy');
                                        }),
                                    Text(
                                      " Rate",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, bottom: 15),
                                child: Column(
                                  children: [
                                    IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.gamepad,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Utils.openLink(
                                              url:
                                                  'https://play.google.com/store/apps/developer?id=Bro+-+Apps');
                                        }),
                                    Text(
                                      "More Games",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, bottom: 15),
                                child: Column(
                                  children: [
                                    IconButton(
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
                                    Text(
                                      "Share",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttonMod(String txt) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              border: Border.all(width: 2, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: InkWell(
            onTap: () {
              widget.ads.showInterstitialAd();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PageResultat(
                        music: txt,
                        ads: ads,
                      )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  txt,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ))
    ]);
  }
}
