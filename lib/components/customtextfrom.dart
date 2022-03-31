
import 'package:flutter/material.dart';

class CustTextFromSign extends StatelessWidget {
  final String hint;
  final bool hide;
  final String? Function(String?) valid;
  final TextEditingController mycontroller;
  const CustTextFromSign(
      {Key? key,
      required this.hint,
      required this.mycontroller,
      required this.valid,
      required this.hide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        obscureText: hide,
        controller: mycontroller,
        validator: valid,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
