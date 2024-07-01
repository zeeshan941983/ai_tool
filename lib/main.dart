import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wezee_tool/components/color.dart';
import 'package:wezee_tool/view/Auth/Sign_Up_screen.dart';
import 'package:wezee_tool/view/Auth/login_screen.dart';
import 'package:wezee_tool/view/Auth/main_Auth.dart';

// import 'package:wezee_tool/view/Auth/main_Auth.dart';
import 'package:wezee_tool/view/HomePage.dart';
import 'package:wezee_tool/view/grammercheck_screen.dart';
import 'package:wezee_tool/view/summerize_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.white,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get backgroundColor => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.mainblack,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MaiAuthScreen(),
        'home': (context) => const HomePage(),
        'signup': (context) => const SignUpScreen(),
        'login': (context) => const LoginScreen(),
        'grammer': (context) => const GrammercheckScreen(),
        'summerize': (context) => const SummerizeScreen(),
      },
    );
  }
}
