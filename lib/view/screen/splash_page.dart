import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 5), (timer) {
      Navigator.of(context).pushReplacement(PageTransition(
          duration:
          const Duration(milliseconds: 500),
          child: const HomePage(),
          type:
          PageTransitionType.rightToLeft));
    },);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/space bg.jpg'),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 250,),
            Text(
              'OUTER',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 55,
                  letterSpacing: 2.5),
            ),
            Text(
              'SPACE',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 55,
                  letterSpacing: 2),
            ),
            Spacer(),
            Text(
              'EXPLORE SOLOR SYSTEM',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
