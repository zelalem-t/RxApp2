import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


import 'home.dart';


class STGSplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<STGSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomePage(),
        title: Text('Welcome to Ethiopian STG',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
        //image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Ethiopian STG"),
        loaderColor: Colors.red

    );
  }
}
