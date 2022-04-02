import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextfrom.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false;
  editNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkEditNote, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes["notes_id"].toString(),
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
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Notes")),
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
                        child: const Text("Edit Note"),
                        onPressed: () async {
                          await editNotes();
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
