import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voucherin/view/Theme/style.dart';
import 'package:voucherin/view/Widget/rounded_button.dart';
import 'package:voucherin/view/Widget/rounded_form.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _email = TextEditingController();
  bool isEmailValid = true;
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  Future submit() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Password Reset Email Sent')),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('assets/forgot.png'),
              ),
              const SizedBox(height: 40),
              Text(
                'Forgot\nPassword?',
                style: blackTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Dont worry! it happens. Please enter the\naddress associated with your account.',
                style: greyTextStyle,
              ),
              const SizedBox(height: 50),
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
              const SizedBox(height: 30),
              RoundedButton(
                onTap: submit,
                label: 'Submit',
              )
            ],
          ),
        ),
      ),
    );
  }
}
