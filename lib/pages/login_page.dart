import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_assistant/constants/consts.dart';
import 'package:flutter_chatgpt_assistant/routes/routes.dart';

// ignore: camel_case_types
class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

// ignore: camel_case_types
class _login_pageState extends State<login_page> {
  String username = "";
  bool changeButton = false;
  final _formkey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      await Navigator.pushNamed(context, MyRoutes.homeRoutes);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Pallete.whiteColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Image.asset(
                "assets/images/undraw_Mobile_application_re_13u3.png",
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "welcome $username",
                style:
                    const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0)),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter Username", labelText: "User Name"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be emoty";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        username = value;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "Enter Password", labelText: "Password"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 6) {
                          return "Password must contain more than 6 letters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                      onTap: () => moveToHome(context),
                      child: AnimatedContainer(
                        // ignore: prefer_const_constructors
                        duration: Duration(seconds: 1),
                        width: changeButton ? 50 : 150,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: const Color.fromARGB(255, 13, 117, 191),
                        ),
                        // ignore: prefer_const_constructors
                        child: changeButton
                            // ignore: prefer_const_constructors
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            // ignore: prefer_const_constructors
                            : Text(
                                "Login",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
