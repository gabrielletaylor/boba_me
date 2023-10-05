import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeddfca),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Boba Me',
                style: TextStyle(
                  fontFamily: 'Gaegu',
                  fontSize: 60,
                  fontWeight: FontWeight.bold
                ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 125,
              width: 125,
              child: Image.asset('assets/images/splash_logo.png'),
            )
          ],
        ),
      )
    );
  }
}
