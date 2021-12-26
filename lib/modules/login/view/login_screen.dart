import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/loading_indicator.dart';
import 'package:movie_app/storage/MovieSharedPreferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var isToShowLoaderIndicator = false;

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _fireBaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 80, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 60,
                ),
                if(!isToShowLoaderIndicator)
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isToShowLoaderIndicator = true;
                    });
                    var result = await signIn(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    ) as String;
                    if (result == "Signed in") {
                      Navigator.pushReplacementNamed(
                          context, "/movieListScreen");
                      await MovieSharedPreferences()
                          .setBoolForKey(preferencesKeys.kUserLoggedIn, true);
                    } else {
                      setState(() {
                        isToShowLoaderIndicator = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                        child: Text(
                      "LOG IN",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent),
                  ),
                ),
                if(isToShowLoaderIndicator)
                  CircularProgressIndicatorWidget(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/signUp");
                      },
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.indigoAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
