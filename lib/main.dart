import "package:boba_me/screens/splash_screen.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Boba Me",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffeec9b7),
          titleTextStyle: TextStyle(
            fontFamily: "Gaegu",
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Color(0xffc37254),
          )
        ),
        fontFamily: "Varela Round",
      ),
      home: const SplashScreen(),
    );
  }
}
