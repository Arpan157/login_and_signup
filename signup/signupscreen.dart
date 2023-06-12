import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_matter/components/Textfield.dart';
import 'package:money_matter/signup/signupservice.dart';

import '../login/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller =
      TextEditingController(text: '');
  final TextEditingController _phonecontroller =
      TextEditingController(text: '');
  final TextEditingController _usernamecontroller =
      TextEditingController(text: '');
  User? currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Signup "),
        backgroundColor: Color(0xff057275),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainTextField(
              hinttext: 'Email ',
              iconn: Icons.email,
              textEditingController: _emailcontroller),
          const SizedBox(
            height: 20,
          ),
          MainTextField(
              hinttext: 'Username',
              iconn: Icons.person,
              textEditingController: _usernamecontroller),
          const SizedBox(
            height: 20,
          ),
          MainTextField(
              hinttext: 'Password',
              iconn: Icons.password,
              textEditingController: _passwordcontroller),
          const SizedBox(
            height: 20,
          ),
          MainTextField(
              hinttext: 'Contact Number',
              iconn: Icons.phone,
              textEditingController: _phonecontroller),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () async {
              var userName =
                  _usernamecontroller.text.toString().trim().toLowerCase();
              var userEmail =
                  _emailcontroller.text.toLowerCase().toString().trim();
              var userPassword =
                  _passwordcontroller.text.toString().trim().toLowerCase();
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: userEmail, password: userPassword)
                  .then((value) => {
                        SignUpUser(userName, userEmail, userPassword),
                        log('user stored'),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreem()))
                      });
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: const Text(
                  'Signup',
                  textAlign: TextAlign.center,
                ),
              ),
              color: Color(0xff057275),
              height: 50,
              width: 80,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text("Already a Member ? Login"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreem()));
            },
          )
        ],
      ),
    );
  }
}
