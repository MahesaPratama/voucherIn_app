import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:voucherin/view/Widget/rounded_button.dart';
import 'package:voucherin/view/Widget/rounded_form.dart';
import 'package:voucherin/view/Theme/style.dart';
import 'package:voucherin/view/Widget/txtbutton.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isEmailValid = true;
  bool isTap = false;
  bool hideText = true;
  Future signIn() async {
    if (isEmailValid == true && _password.text.length >= 6) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, '/navbar', (route) => false);
      } on FirebaseAuthException catch (e) {
        // ignore: avoid_print
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please check you email / password.',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future signUp() async {
    if (isEmailValid == true && _password.text.length >= 6) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, '/navbar', (route) => false);
      } on FirebaseAuthException catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Enter valid email or 6 character password required.',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isTap == false
                            ? 'Welcome Back'
                            : 'Create a New Account',
                        style: blueTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        FontAwesome.hand_peace,
                        color: Colors.amber,
                        size: 30,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isTap == false
                        ? 'Great to have you here! Please login to manage your mobile top-up, data and other transactions.'
                        : 'Create an account now to start managing your mobile transactions, including credit top-up and data purchases.',
                    style: greyTextStyle,
                  ),
                  const SizedBox(height: 50),
                  const Center(
                    child: Image(
                      image: AssetImage('assets/login.png'),
                      width: 262,
                      height: 240,
                    ),
                  ),
                  const SizedBox(height: 40),
                  RoundedForm(
                    label: 'Email Address',
                    controller: _email,
                    onChanged: (val) {
                      bool isValid = EmailValidator.validate(val);
                      if (isValid) {
                        setState(() {
                          isEmailValid = true;
                        });
                      } else {
                        setState(() {
                          isEmailValid = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  RoundedForm(
                    label: 'Password',
                    controller: _password,
                    hideText: hideText,
                    icon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            hideText = !hideText;
                          });
                        },
                        icon: hideText == true
                            ? Icon(
                                IonIcons.eye,
                                color: royalBlue,
                              )
                            : Icon(
                                IonIcons.eye_off,
                                color: royalBlue,
                              )),
                    hintText: 'Use at least 6 characters',
                  ),
                  isTap == false
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forgot');
                              },
                              child: Text(
                                'Forgot Password?',
                                style: blueTextStyle,
                                textAlign: TextAlign.end,
                              )),
                        )
                      : const Text(''),
                  const SizedBox(height: 30),
                  RoundedButton(
                      onTap: isTap == false ? signIn : signUp,
                      label: isTap == false ? 'Sign In' : 'Sign Up'),
                  const SizedBox(height: 10),
                  TxtButton(
                      onTap: () {
                        setState(() {
                          isTap = !isTap;
                        });
                      },
                      label: isTap == false
                          ? 'Create New Account'
                          : 'Already have an account'),
                ],
              ),
            ),
          ),
        ));
  }
}
