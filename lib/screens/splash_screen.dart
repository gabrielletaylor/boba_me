import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDDFCA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                  'Boba Me',
                  style: TextStyle(
                    fontFamily: 'Gaegu',
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
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
