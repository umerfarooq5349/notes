import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/styles/app_styles.dart';
import 'package:notes/widgets/note_card.dart';

class ReadNoteScreen extends StatefulWidget {
  final String id;
  final String title;
  final String body;
  final String date;

  const ReadNoteScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  }) : super(key: key);

  @override
  State<ReadNoteScreen> createState() => _ReadNoteScreenState();
}

class _ReadNoteScreenState extends State<ReadNoteScreen> {
  final readNote = FirebaseFirestore.instance.collection('notes');
  final editTitle = TextEditingController();
  final editBody = TextEditingController();
  int random = Random().nextInt(7);

  @override
  void initState() {
    super.initState();

    editBody.text = widget.body;
    editTitle.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.gradients[0].first,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.amber)),
            onPressed: () {
              readNote.doc(widget.id.toString()).update({
                'title': editTitle.text,
                'body': editBody.text,
                'id': widget.id,
                'date': DateFormat('EEEE, MMM d, yyyy').format(DateTime.now()),
              }).then((value) {
                Utils().toastMassage('Updated', Colors.green);
              }).onError((error, stackTrace) {
                Utils().toastMassage(error.toString(), Colors.red);
              });
            },
            child: Text(
              'Save',
              style: AppStyle.mainTitle,
            ),
          ),
          const SizedBox(width: 20),
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: editTitle,
          textAlign: TextAlign.center,
          style: AppStyle.mainTitle.copyWith(color: Colors.white),
          decoration: const InputDecoration(
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
                  controller: editBody,
                  style: AppStyle.mainContent.copyWith(color: Colors.white),
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(
                widget.date,
                style: AppStyle.date,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
