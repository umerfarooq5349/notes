import 'package:flutter/material.dart';
import 'package:notes/UI/add_note.dart';
import 'package:notes/UI/notes/read_notes.dart';
import 'package:notes/styles/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/widgets/note_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tableRef = FirebaseFirestore.instance.collection('notes').snapshots();
  final notes = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      appBar: AppBar(
        title: Text(
          'Notes',
          style: AppStyle.appBar.copyWith(color: AppStyle.purpule),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: tableRef,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No notes are added yet ):',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        );
                      }
                      return MasonryGridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return NoteCard(
                            title: snapshot.data!.docs[index]['title']
                                .toString()
                                .toUpperCase(),
                            body: snapshot.data!.docs[index]['body'].toString(),
                            date: snapshot.data!.docs[index]['date'].toString(),
                            onLongPress: () {
                              showAlret(snapshot.data!.docs[index]['id'],
                                  snapshot.data!.docs[index]['title']);
                            },
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ReadNoteScreen(
                                    id: snapshot.data!.docs[index]['id'],
                                    title: snapshot.data!.docs[index]['title']
                                        .toString(),
                                    body: snapshot.data!.docs[index]['body']
                                        .toString(),
                                    date: snapshot.data!.docs[index]['date']
                                        .toString(),
                                  );
                                },
                              ));
                            },
                          );
                        },
                      );
                    } else {
                      return const Text(
                        'No notes are added yet ):',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddNoteScreen();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showAlret(String id, title) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppStyle.bgColor,
          title: Text(
            'Delete $title?',
            style: AppStyle.mainTitle.copyWith(color: AppStyle.purpule),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  return;
                },
                style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(
                    AppStyle.mainContent.copyWith(color: AppStyle.purpule),
                  ),
                ),
                child: Text(
                  'No',
                  style: AppStyle.mainContent.copyWith(color: AppStyle.purpule),
                )),
            TextButton(
              onPressed: () {
                notes.doc(id).delete().then((value) {
                  Utils().toastMassage('Deleted', Colors.green);
                }).onError((error, stackTrace) {
                  Utils().toastMassage(error.toString(), Colors.red);
                });
                return;
              },
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                  AppStyle.mainContent.copyWith(color: AppStyle.purpule),
                ),
              ),
              child: Text(
                'Yes, delete it',
                style: AppStyle.mainContent.copyWith(color: AppStyle.purpule),
              ),
            ),
          ],
        );
      },
    );
  }
}
