import 'package:flutter/material.dart';
import 'package:notes/styles/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userName = TextEditingController();
  final password = TextEditingController();
  bool showpass = true;
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
                height: 80,
              ),
              Text(
                "Let's sign you in",
                style: AppStyle.appBar
                    .copyWith(fontSize: 24, color: AppStyle.purpule),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Welcome back",
                style: AppStyle.mainContent
                    .copyWith(fontSize: 24, color: AppStyle.purpule),
              ),
              Text(
                "We are missing you",
                style: AppStyle.mainContent
                    .copyWith(fontSize: 24, color: AppStyle.purpule),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User name",
                    style:
                        AppStyle.mainContent.copyWith(color: AppStyle.purpule),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    cursorColor: AppStyle.purpule,
                    controller: userName,
                    style:
                        AppStyle.mainContent.copyWith(color: AppStyle.purpule),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "user_name",
                      hintStyle:
                          AppStyle.hintText.copyWith(color: AppStyle.purpule),
                      enabled: true,
                      filled: true,
                      fillColor: AppStyle.purpule.withOpacity(0.03),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(width: 2, color: AppStyle.purpule),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(width: 2, color: AppStyle.purpule),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(width: 2, color: AppStyle.purpule),
                      ),
                    ),
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
                    style:
                        AppStyle.mainContent.copyWith(color: AppStyle.purpule),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    cursorColor: AppStyle.purpule,
                    controller: password,
                    obscureText: showpass,
                    style:
                        AppStyle.mainContent.copyWith(color: AppStyle.purpule),
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
                            BorderSide(width: 2, color: AppStyle.purpule),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(width: 2, color: AppStyle.purpule),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(width: 2, color: AppStyle.purpule),
                      ),
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.all(0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Forget Password",
                          style: AppStyle.mainTitle
                              .copyWith(fontSize: 16, color: AppStyle.purpule),
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
                            .copyWith(color: AppStyle.purpule),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style: AppStyle.mainTitle
                              .copyWith(fontSize: 16, color: AppStyle.purpule),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Login",
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
                    border: Border.all(width: 2, color: AppStyle.purpule),
                    borderRadius: BorderRadius.circular(16)),
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      elevation: MaterialStatePropertyAll(0)),
                  onPressed: () {},
                  child: Text(
                    "Sign in with Google",
                    style: AppStyle.mainContent
                        .copyWith(fontSize: 20, color: AppStyle.purpule),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
