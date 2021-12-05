import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scs_project/database/database.dart';
import 'package:scs_project/users/custom_user.dart';

class Notes extends StatefulWidget {
  final CustomUser user;
  const Notes({Key? key, required this.user}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late CustomUser user;
  List<String> personalNotes = [];
  final TextEditingController _textFieldController = TextEditingController();
  String newValue = "";

  @override
  void initState() {
    user = widget.user;
    if (personalNotes.isEmpty) getNotes();
    super.initState();
  }

  void getNotes() async {
    List<dynamic> auxNotes = await Database(uid: user.uid).getPersonalNotes();
    for (var dyn in auxNotes) {
      personalNotes.add(dyn.toString());
    }
  }

  void removeNote(int index) {
    setState(() {
      personalNotes.removeAt(index);
      Database(uid: user.uid).updateUserNotes(personalNotes);
    });
  }

  void addNote() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Add a new note'),
              content: Wrap(
                children: [
                  TextField(
                    onChanged: (value) {
                      newValue = value;
                    },
                    controller: _textFieldController,
                    decoration:
                        const InputDecoration(hintText: "personal note"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        personalNotes.add(newValue);
                        Navigator.pop(context);
                        Database(uid: user.uid).updateUserNotes(personalNotes);
                      });
                    },
                    child: const Text("Add"),
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          int listLenght = personalNotes.length;
          return personalNotes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: listLenght,
                  itemBuilder: (context, index) {
                    return Wrap(
                      children: [
                        ElevatedButton(
                          onPressed: () => removeNote(index),
                          child: const Text("X"),
                        ),
                        Center(
                          child: Text(
                            personalNotes[index],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}
