import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerceproject/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'signin.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreenpage extends StatefulWidget {
  static SharedPreferences? prefs;

  @override
  State<Splashscreenpage> createState() => _SplashscreenpageState();
}

class _SplashscreenpageState extends State<Splashscreenpage> {

  bool loginstatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    forsharepref();
  }

  forsharepref() async {

    Splashscreenpage.prefs = await SharedPreferences.getInstance();

    setState(() {
      loginstatus = Splashscreenpage.prefs!.getBool('loginstatus')??false;
    });

    Future.delayed(Duration(seconds: 3)).then((value) {
      if(loginstatus){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Homepage();
        },));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Signinpage();
        },));
      }
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "RawAnimation/splashani.json",
            frameRate: FrameRate(60),
            animate: true,
          ),
          Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            child: DefaultTextStyle(
              style: GoogleFonts.almarai(
                  fontSize: 28,
                  color: Colors.black
                ),
              child: AnimatedTextKit(animatedTexts: [
                ScaleAnimatedText("Keep Calm",duration: Duration(milliseconds: 1000)),
                ScaleAnimatedText("Until it's Your Turn",duration: Duration(milliseconds: 1000)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
