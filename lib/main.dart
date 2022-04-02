import 'package:flutter/material.dart';
import 'package:noteapp/app/auth/signup.dart';
import 'package:noteapp/app/auth/login.dart';
import 'package:noteapp/app/auth/success.dart';
import 'package:noteapp/app/home.dart';
import 'package:noteapp/app/note/add_notes.dart';
import 'package:noteapp/app/note/edit_notes.dart';
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
        "login": (context) => const Login(),
        "signup": (contex) => const SignUp(),
        "home": (context) => const Home(),
        "success": (contex) => const Success(),
        "addnotes": (contex) => const AddNotes(),
        "editnotes": (contex) => const EditNotes(),
      },
    );
  }
}
