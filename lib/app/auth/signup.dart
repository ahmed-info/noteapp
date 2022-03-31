import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';

import '../../components/customtextfrom.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  final Crud _crud = Crud();
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("SignUp Fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
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
                          return validInput(val!, 3, 20);
                        },
                        mycontroller: username,
                        hint: "username",
                      ),
                      CustTextFromSign(
                        hide: false,
                        valid: (val) {
                          return validInput(val!, 5, 40);
                        },
                        mycontroller: email,
                        hint: "email",
                      ),
                      CustTextFromSign(
                        hide: true,
                        valid: (val) {
                          return validInput(val!, 3, 10);
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
                          await signUp();
                        },
                        child: const Text(
                          "SignUp",
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      InkWell(
                        child: const Text("Login"),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed("login");
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
