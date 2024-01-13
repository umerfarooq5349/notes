import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/styles/app_styles.dart';
import 'package:notes/widgets/note_card.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  var readNote;
  final editTitle = TextEditingController();
  final editBody = TextEditingController();
  int random = Random().nextInt(7);
  String id = DateTime.now().millisecond.toString();
  final auth = FirebaseAuth.instance;
  var userId;
  bool saving = false;
  @override
  void initState() {
    if (auth.currentUser != null) {
      userId = auth.currentUser!.uid;
    }
    readNote = FirebaseFirestore.instance.collection("$userId\notes");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.gradients[0].first,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        // centerTitle: true,
        actions: [
          TextButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.amber)),
            onPressed: () {
              setState(() {
                saving = true;
              });
              readNote.doc(id).set({
                'id': id,
                'title': editTitle.text,
                'body': editBody.text,
                'date': DateFormat('EEEE, MMM d, yyyy').format(DateTime.now()),
              }).then((value) {
                setState(() {
                  saving = false;
                });
                Utils().toastMassage('Saved', AppStyle.purpule);
              }).catchError((error) {
                Utils().toastMassage(error.toString(), Colors.red);
                setState(() {
                  saving = false;
                });
              });
            },
            child: !saving
                ? Text(
                    'Save',
                    style: AppStyle.mainTitle,
                  )
                : CircularProgressIndicator(color: AppStyle.whiteColor),
          ),
          const SizedBox(width: 20),
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: TextField(
          cursorColor: Colors.white,
          controller: editTitle,
          textAlign: TextAlign.center,
          style: AppStyle.mainTitle.copyWith(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Title: Awesome time spend',
            hintStyle: AppStyle.hintText.copyWith(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              colors: AppStyle.gradients[0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: AppStyle.gradients[0].last.withOpacity(0.5),
                offset: const Offset(0.1, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  cursorColor: Colors.white,
                  cursorHeight: 20.2,
                  controller: editBody,
                  style: AppStyle.mainContent.copyWith(color: Colors.white),
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Today i've spend awesome time ",
                    hintStyle: AppStyle.hintText
                        .copyWith(color: Colors.white.withOpacity(0.5)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
