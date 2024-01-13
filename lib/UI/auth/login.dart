import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/UI/auth/signup_screen.dart';
import 'package:notes/UI/home_screen.dart';
import 'package:notes/styles/app_styles.dart';
import 'package:notes/widgets/note_card.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userEmail = TextEditingController();
  final password = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool showpass = true;
  bool loading = false;
  final key = GlobalKey<FormState>();
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: ListView(children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                "Let's sign you in",
                style: AppStyle.appBar
                    .copyWith(fontSize: 24, color: AppStyle.brown),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Welcome back",
                style: AppStyle.mainContent
                    .copyWith(fontSize: 24, color: AppStyle.brown),
              ),
              Text(
                "We are missing you",
                style: AppStyle.mainContent
                    .copyWith(fontSize: 24, color: AppStyle.brown),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: key,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: AppStyle.mainContent
                              .copyWith(color: AppStyle.brown),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          cursorColor: AppStyle.brown,
                          controller: userEmail,
                          style: AppStyle.mainContent
                              .copyWith(color: AppStyle.brown),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "example@example.com",
                            hintStyle: AppStyle.hintText
                                .copyWith(color: AppStyle.brown),
                            enabled: true,
                            filled: true,
                            fillColor: AppStyle.purpule.withOpacity(0.03),
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
                          "Password",
                          style: AppStyle.mainContent
                              .copyWith(color: AppStyle.brown),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          cursorColor: AppStyle.brown,
                          controller: password,
                          obscureText: showpass,
                          style: AppStyle.mainContent
                              .copyWith(color: AppStyle.brown),
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
                            fillColor: AppStyle.purpule.withOpacity(0.03),
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
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.all(0),
                          ),
                        ),
                        onPressed: () {
                          Utils().toastMassage(
                              'This is not implemented yet', AppStyle.purpule);
                        },
                        child: Text(
                          "Forget Password",
                          style: AppStyle.mainTitle
                              .copyWith(fontSize: 16, color: AppStyle.brown),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppStyle.mainContent
                            .copyWith(color: AppStyle.brown),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SignUpScreen();
                            },
                          ));
                        },
                        child: Text(
                          "Sign Up",
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
                    login();
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
                    signInWithGoogle();
                  },
                  child: Text(
                    "Login in with Google",
                    style: AppStyle.mainContent
                        .copyWith(fontSize: 20, color: AppStyle.brown),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void login() {
    setState(() {
      loading = true;
    });

    auth
        .signInWithEmailAndPassword(
            email: userEmail.text, password: password.text)
        .then((value) {
      Utils().toastMassage('Loging in', AppStyle.purpule);

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ));
      setState(() {
        loading = false;
      });
    }).catchError((error, stackTrace) {
      Utils().toastMassage(error.toString(), AppStyle.error);
      setState(() {
        loading = false;
      });
    });
  }

// Future<UserCredential?> _signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//       return await APIs.auth.signInWithCredential(credential);
//     } catch (e) {
//       log('\n_signInWithGoogle: $e');
//       Dialogs.showSnackBar(context, 'You need an Active Internet Connection!');
//       return null;
//     }
//   }
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
// final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential);

        Utils().toastMassage('Login with Google successful', AppStyle.purpule);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        Utils().toastMassage('Google Sign-In canceled', AppStyle.error);
      }
    } catch (e) {
      Utils().toastMassage('Error during Google Sign-In', AppStyle.error);
    }
  }
}
