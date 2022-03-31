// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

import '../../components/customtextfrom.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final Crud _crud = Crud();
  bool isLoading = false;
  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });
      isLoading = false;
      if (response['status'] == "success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            title: "تنبية",
            body: const Text("البريد الالكتروني او كلمة المرور غير صحيحة"))
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Form(
                    key: formstate,
                    child: Column(children: [
                      Image.asset(
                        "images/logo.png",
                        width: 200,
                        height: 200,
                      ),
                      CustTextFromSign(
                        hide: false,
                        valid: (val) {
                          return validInput(val!, 3, 25);
                        },
                        mycontroller: email,
                        hint: "email",
                      ),
                      CustTextFromSign(
                        hide: true,
                        valid: (val) {
                          return validInput(val!, 5, 20);
                        },
                        mycontroller: password,
                        hint: "password",
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        onPressed: () async {
                          await login();
                        },
                        child: const Text(
                          "Login",
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      InkWell(
                        child: const Text("sign up"),
                        onTap: () {
                          Navigator.of(context).pushNamed("signup");
                        },
                      )
                    ]),
                  )
                ],
              ),
      ),
    );
  }
}
