import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:rx_app/screens/home.dart';
import 'package:rx_app/screens/splashscreen.dart';
import 'package:rx_app/states/statemanager.dart';
//import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context)=>DbStateProvider(),
      child:RxApp(),
     )

      );
}

class RxApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethiopian ETG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18),
          headline1: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
          headline4: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          headline5: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
          subtitle1: TextStyle(fontSize:16),

        ),
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: "Serif",
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: STGSplashScreen(),
    );
  }
}


