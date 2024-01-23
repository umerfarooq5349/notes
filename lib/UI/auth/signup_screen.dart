import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/UI/auth/login.dart';
import 'package:notes/UI/home_screen.dart';
import 'package:notes/styles/app_styles.dart';
import 'package:notes/widgets/note_card.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userEmail = TextEditingController();
  final password = TextEditingController();
  final userName = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool showpass = true, loading = false;
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: ListView(children: [
          Form(
            key: key,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Let's sign up",
                  style: AppStyle.appBar
                      .copyWith(fontSize: 24, color: AppStyle.brown),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Let's create your account",
                  style: AppStyle.mainContent
                      .copyWith(fontSize: 24, color: AppStyle.brown),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style:
                          AppStyle.mainContent.copyWith(color: AppStyle.brown),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      cursorColor: AppStyle.brown,
                      controller: userName,
                      style:
                          AppStyle.mainContent.copyWith(color: AppStyle.brown),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Jahan",
                        hintStyle:
                            AppStyle.hintText.copyWith(color: AppStyle.brown),
                        enabled: true,
                        filled: true,
                        fillColor: AppStyle.brown.withOpacity(0.03),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                        // error: const Text('This is requied field'),
                        // errorBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(8),
                        //   borderSide:
                        //       BorderSide(width: 2, color: AppStyle.error),
                        // ),
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
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style:
                          AppStyle.mainContent.copyWith(color: AppStyle.brown),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      cursorColor: AppStyle.brown,
                      controller: userEmail,
                      style:
                          AppStyle.mainContent.copyWith(color: AppStyle.brown),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "example@example.com",
                        hintStyle:
                            AppStyle.hintText.copyWith(color: AppStyle.brown),
                        enabled: true,
                        filled: true,
                        fillColor: AppStyle.brown.withOpacity(0.03),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                        // error: const Text('This is requied field'),
                        // errorBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(8),
                        //   borderSide:
                        //       BorderSide(width: 2, color: AppStyle.error),
                        // ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "8 digit password",
                      style:
                          AppStyle.mainContent.copyWith(color: AppStyle.brown),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      cursorColor: AppStyle.brown,
                      controller: password,
                      obscureText: showpass,
                      style:
                          AppStyle.mainContent.copyWith(color: AppStyle.brown),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (showpass) {
                                showpass = false;
                              } else {
                                showpass = true;
                              }
                            });
                          },
                          icon: const Icon(Icons.lock),
                        ),
                        enabled: true,
                        filled: true,
                        fillColor: AppStyle.brown.withOpacity(0.03),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 2, color: AppStyle.brown),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Already have and account",
                          style: AppStyle.mainContent
                              .copyWith(color: AppStyle.brown),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const LoginScreen();
                              },
                            ));
                          },
                          child: Text(
                            "Login",
                            style: AppStyle.mainTitle
                                .copyWith(fontSize: 16, color: AppStyle.brown),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppStyle.purpule)),
                    onPressed: () {
                      signUp();
                    },
                    child: loading
                        ? CircularProgressIndicator(
                            color: AppStyle.whiteColor,
                          )
                        : Text(
                            'Login',
                            style: AppStyle.appBar.copyWith(fontSize: 20),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppStyle.brown),
                      borderRadius: BorderRadius.circular(16)),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      signUpWithGoogle();
                    },
                    child: Text(
                      "Sign up with Google",
                      style: AppStyle.mainContent
                          .copyWith(fontSize: 20, color: AppStyle.brown),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    if (userEmail.text.isEmpty ||
        userName.text.isEmpty ||
        password.text.isEmpty) {
      setState(() {
        loading = false;
      });
      Utils().toastMassage('All feilds are required', AppStyle.purpule);
    } else {
      auth
          .createUserWithEmailAndPassword(
              email: userEmail.text, password: password.text)
          .then((value) async {
        await auth.currentUser!.updateDisplayName(userName.text);
        Utils().toastMassage('User created, logining', AppStyle.purpule);
        setState(() {
          loading = false;
        });
        // ignore: use_build_context_synchronously
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
      }).catchError((error, stackTrace) {
        Utils().toastMassage(error.toString(), AppStyle.error);
        setState(() {
          loading = false;
        });
      });
    }
  }

  void signUpWithGoogle() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      auth.signInWithProvider(googleAuthProvider).then((value) {
        Utils().toastMassage('Signup Successfull', AppStyle.purpule);
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
      }).onError((error, stackTrace) {
        Utils().toastMassage(error.toString(), AppStyle.error);
      });
    } catch (e) {
      Utils().toastMassage(e.toString(), AppStyle.error);
    }
  }
}
