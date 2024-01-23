import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:notes/UI/add_note.dart';
import 'package:notes/UI/auth/login.dart';
import 'package:notes/UI/notes/read_notes.dart';
import 'package:notes/styles/app_styles.dart';
import 'package:notes/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tableRef;
  var notes;
  bool loading = false;
  bool loadingImg = false;
  final auth = FirebaseAuth.instance;
  var userId;
  String id = DateTime.now().millisecond.toString();
  int totalNotes = 0;
  final userName = TextEditingController();
  String? imgURL;
  var storageRef;
  @override
  void initState() {
    userId = auth.currentUser!.uid;
    tableRef =
        FirebaseFirestore.instance.collection('$userId\notes').snapshots();
    notes = FirebaseFirestore.instance.collection('$userId\notes');

    storageRef = FirebaseFirestore.instance.collection('$userId\nimages');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppStyle.bgColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppStyle.purpule,
                  gradient: LinearGradient(
                      colors: AppStyle.bgGradient,
                      tileMode: TileMode.decal,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      uploadImg();
                    },
                    child: CircleAvatar(
                      maxRadius: 60,
                      minRadius: MediaQuery.of(context).size.width * 0.02,
                      backgroundImage: imgURL != null
                          ? NetworkImage(imgURL!)
                          : const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNAUvIj8tIlcc6MemlkLaXGlOLNplzf-3euA&usqp=CAU'),
                      child: loadingImg
                          ? const CircularProgressIndicator()
                          : Container(),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: AppStyle.whiteColor,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text(
                  auth.currentUser?.displayName?.toString() ?? 'Default Name',
                  style:
                      AppStyle.mainContent.copyWith(color: AppStyle.whiteColor),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: MediaQuery.of(context).size.width * 0.07,
                  ),
                  onPressed: () {
                    updateName('Update your display name');
                  },
                  color: AppStyle.whiteColor,
                ),
              ),
              const CustomDivider(),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: AppStyle.whiteColor,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text(
                  auth.currentUser?.email?.toString() ?? '',
                  style:
                      AppStyle.mainContent.copyWith(color: AppStyle.whiteColor),
                ),
              ),
              const CustomDivider(),
              ListTile(
                leading: Icon(
                  Icons.military_tech,
                  color: AppStyle.whiteColor,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
                title: Text(
                  "Total Notes",
                  style:
                      AppStyle.mainContent.copyWith(color: AppStyle.whiteColor),
                ),
                trailing: Text(
                  totalNotes.toString(),
                  style:
                      AppStyle.mainContent.copyWith(color: AppStyle.whiteColor),
                ),
              ),
              const CustomDivider(),
              ListTile(
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.signOut().then((value) {
                    Utils().toastMassage('Loging out', AppStyle.purpule);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ));
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMassage(error.toString(), AppStyle.error);
                    setState(() {
                      loading = false;
                    });
                  });
                },
                leading: loading
                    ? CircularProgressIndicator(
                        color: AppStyle.whiteColor,
                      )
                    : Icon(
                        Icons.logout,
                        color: AppStyle.whiteColor,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                title: Text(
                  'Log out',
                  style:
                      AppStyle.mainContent.copyWith(color: AppStyle.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppStyle.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppStyle.gradients[0][0], size: 30),
        title: Text(
          'Notes',
          style: AppStyle.appBar.copyWith(color: AppStyle.gradients[0][0]),
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
          // ignore: avoid_print
          print(auth.currentUser!.providerData);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddNoteScreen();
            },
          ));
        },
        child: Icon(
          Icons.add,
          color: AppStyle.whiteColor,
        ),
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
            style: AppStyle.mainTitle.copyWith(color: AppStyle.brown),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(
                    AppStyle.mainContent.copyWith(color: AppStyle.brown),
                  ),
                ),
                child: Text(
                  'No',
                  style: AppStyle.mainContent.copyWith(color: AppStyle.brown),
                )),
            TextButton(
              onPressed: () {
                notes.doc(id).delete().then((value) {
                  Utils().toastMassage('Deleted', AppStyle.purpule);
                  Navigator.pop(context);
                }).catchError((error, stackTrace) {
                  Utils().toastMassage(error.toString(), AppStyle.error);
                  Navigator.pop(context);
                });
              },
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                  AppStyle.mainContent.copyWith(color: AppStyle.purpule),
                ),
              ),
              child: Text(
                'Yes, delete it',
                style: AppStyle.mainContent.copyWith(color: AppStyle.brown),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateName(String title) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppStyle.bgColor,
          title: Text(
            title,
            style: AppStyle.mainTitle.copyWith(color: AppStyle.brown),
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: AppStyle.mainContent.copyWith(color: AppStyle.brown),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  cursorColor: AppStyle.brown,
                  controller: userName,
                  style: AppStyle.mainContent.copyWith(color: AppStyle.brown),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    enabled: true,
                    filled: true,
                    fillColor: AppStyle.brown.withOpacity(0.03),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 2, color: AppStyle.brown),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 2, color: AppStyle.brown),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 2, color: AppStyle.brown),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      textStyle: MaterialStatePropertyAll(
                        AppStyle.mainContent.copyWith(color: AppStyle.brown),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style:
                          AppStyle.mainContent.copyWith(color: AppStyle.brown),
                    )),
                TextButton(
                  onPressed: () {
                    auth.currentUser!
                        .updateDisplayName(userName.text)
                        .then((value) {
                      Utils().toastMassage(
                          'Your display name is updated', AppStyle.purpule);

                      Navigator.pop(context);
                      setState(() {});
                    });
                  },
                  style: ButtonStyle(
                    textStyle: MaterialStatePropertyAll(
                      AppStyle.mainContent.copyWith(color: AppStyle.purpule),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: AppStyle.mainContent.copyWith(color: AppStyle.brown),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> uploadImg() async {
    setState(() {
      loadingImg = true;
    });

    ImagePicker imgPicker = ImagePicker();
    XFile? file = await imgPicker.pickImage(source: ImageSource.gallery);

    if (file == null) {
      setState(() {
        loadingImg = false;
      });
      return;
    }

    final fileExtension = p.extension(file.path);
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImg = referenceRoot.child('$userId/nimages');
    Reference referenceOfImg = referenceDirImg.child(
        "${auth.currentUser!.displayName}${DateTime.now().millisecond}$fileExtension");

    try {
      await referenceOfImg.putFile(File(file.path));
      String newImgURL = await referenceOfImg.getDownloadURL();

      auth.currentUser!.updatePhotoURL(newImgURL);
      storageRef.doc(id).set({'id': id, 'imgURL': imgURL});
      setState(() {
        Utils().toastMassage('Img uploaded', AppStyle.purpule);
        imgURL = newImgURL;
        loadingImg = false;
      });
    } catch (e) {
      setState(() {
        loadingImg = false;
        Utils().toastMassage('Img uploading error', AppStyle.error);
      });
    }
  }
}
