import 'package:flutter/material.dart';
import 'package:noteapp/app/auth/signup.dart';
import 'package:noteapp/app/auth/login.dart';
import 'package:noteapp/app/auth/success.dart';
import 'package:noteapp/app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course PHP Rest API',
      initialRoute: sharedPref.getString('id') == null ? "login" : "home",
      routes: {
        "home": (context) => const Home(),
        "login": (context) => const Login(),
        "signup": (contex) => const SignUp(),
        "success": (contex) => const Success(),
      },
    );
  }
}
