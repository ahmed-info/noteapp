import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextfrom.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false;
  addNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkAddNote, {
        "title": title.text,
        "content": content.text,
        "id": sharedPref.getString("id"),
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Notes")),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustTextFromSign(
                      hide: false,
                      mycontroller: title,
                      hint: "title",
                      valid: (val) {
                        return validInput(val!, 3, 40);
                      },
                    ),
                    CustTextFromSign(
                      hide: false,
                      mycontroller: content,
                      hint: "content",
                      valid: (val) {
                        return validInput(val!, 3, 255);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: const Text("Add Note"),
                        onPressed: () async {
                          await addNotes();
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
