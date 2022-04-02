import 'package:flutter/material.dart';
import 'package:noteapp/app/note/edit_notes.dart';
import 'package:noteapp/components/cardnote.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response = await postRequest(linkViewNote, {
      "id": sharedPref.getString('id'),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(('login'), (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data["status"] == 'error') {
                    return const Center(
                        child: Text(
                      "لاتوجد ملاحظات",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return CardNote(
                            ontap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditNotes(
                                      notes: snapshot.data['data'][i]),
                                ),
                              );
                            },
                            title: "${snapshot.data['data'][i]['notes_title']}",
                            content:
                                "${snapshot.data['data'][i]['notes_content']}");
                      });
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return widget;
              }),
        ]),
      ),
    );
  }
}
