import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:notes/styles/app_styles.dart';

// ignore: must_be_immutable
class NoteCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  NoteCard({
    Key? key,
    required this.title,
    required this.body,
    required this.date,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);
  int random = Random().nextInt(5);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                colors: AppStyle.bgGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            boxShadow: [
              BoxShadow(
                  color: AppStyle.bgGradient.last,
                  offset: const Offset(
                    0.1,
                    5,
                  ),
                  // spreadRadius: 2,
                  blurRadius: 4),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyle.mainTitle,
            ),
            Text(
              body,
              style: AppStyle.mainContent,
            ),
            Text(
              date,
              style: AppStyle.date,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class Utils {
  void toastMassage(String title, Color color) {
    Fluttertoast.showToast(
      msg: title,
      backgroundColor: color,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
    );
  }
}
