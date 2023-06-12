import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_matter/components/Textfield.dart';
import 'package:money_matter/components/mainbutton.dart';
import 'package:money_matter/homepage/homepage.dart';
import 'package:money_matter/screens/bottomnavigationbar.dart';

import '../signup/signupscreen.dart';

class LoginScreem extends StatefulWidget {
  const LoginScreem({super.key});

  @override
  State<LoginScreem> createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  final TextEditingController _emailcontroller =
      TextEditingController(text: '');

  final TextEditingController _passwordcontroller =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff057275),
        title: Center(child: const Text('MoneyMatters')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainTextField(
                hinttext: 'Email',
                iconn: Icons.email,
                textEditingController: _emailcontroller),
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
            ButtonB(
              nameofbutton: 'Login',
              ontap: () async {
                var LoginEmail =
                    _emailcontroller.text.toString().toLowerCase().trim();
                var LoginPassword =
                    _passwordcontroller.text.trim().toString().toLowerCase();
                try {
                  final Set<User?> firebaseUser = {
                    (await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: LoginEmail, password: LoginPassword))
                        .user,
                  };
                  // ignore: unnecessary_null_comparison
                  if (firebaseUser != null) {
                    // ignore: use_build_context_synchronously
                    (Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Bottom()))));
                  } else {
                    print('check your email and password');
                  }
                } on FirebaseAuthException catch (e) {
                  print("error on $e");
                }
              },
              colorofbutton: Color(0xff057275),
              heightofbutton: 40,
              widthofbutton: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text("Not a member ? signup"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
