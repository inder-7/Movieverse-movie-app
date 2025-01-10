import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
  }

  _navigateToMainScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Delay for 3 seconds
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash_image.png', scale: 8,),
            Text("MOVIEVERSE", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),)
          ],
        ), 
      ),
    );
  }
}