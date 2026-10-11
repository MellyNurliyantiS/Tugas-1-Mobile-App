import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    starSplashScreen();
  }

  starSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, (){
     Navigator.of(context).pushReplacement(
       MaterialPageRoute(builder: (context) => MyApp()),
     );
   });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/splash.png',
                width: 800.0,
                height: 400.0,
                fit: BoxFit.contain,
              ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            'flutter_application_1',
            style:TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 235, 231, 231),
            ),
          ),
        ],
      ),    
    );
  }
}