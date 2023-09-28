import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:voucherin/view/Theme/style.dart';

class PinConfirmPage extends StatefulWidget {
  const PinConfirmPage({super.key});

  @override
  State<PinConfirmPage> createState() => _PinConfirmPageState();
}

class _PinConfirmPageState extends State<PinConfirmPage> {
  String _pin = "";
  TextEditingController pinController = TextEditingController(text: '');

  void addPin(String number) {
    if (pinController.text.length < 6) {
      setState(() {
        pinController.text = pinController.text + number;
      });
    }
  }

  void deletePin() {
    if (pinController.text.isNotEmpty) {
      setState(() {
        pinController.text =
            pinController.text.substring(0, pinController.text.length - 1);
      });
    }
  }

  void _getPin() async {
    final user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('${user!.email} PIN')
        .doc('user_pin')
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _pin = data['pin'];
      });
    }
  }

  

  @override
  void dispose() {
    super.dispose();
    pinController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getPin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 15,
          ),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/pin.png'),
                height: 190,
              ),
              const SizedBox(height: 15),
              Text(
                'Please Enter Your Pin',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                enabled: false,
                obscureText: true,
                controller: pinController,
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 30,
                  letterSpacing: 16,
                ),
                decoration: InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                  color: darkRoyalBlue,
                  width: 2,
                ))),
              ),
              const SizedBox(height: 25),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 35,
                ),
                shrinkWrap: true,
                children: [
                  number(() {
                    addPin('1');
                  }, '1'),
                  number(() {
                    addPin('2');
                  }, '2'),
                  number(() {
                    addPin('3');
                  }, '3'),
                  number(() {
                    addPin('4');
                  }, '4'),
                  number(() {
                    addPin('5');
                  }, '5'),
                  number(() {
                    addPin('6');
                  }, '6'),
                  number(() {
                    addPin('7');
                  }, '7'),
                  number(() {
                    addPin('8');
                  }, '8'),
                  number(() {
                    addPin('9');
                  }, '9'),
                  IconButton(
                      onPressed: () {
                        deletePin();
                      },
                      icon: Icon(
                        FontAwesome.delete_left,
                        color: cranberry,
                      )),
                  number(() {
                    addPin('0');
                  }, '0'),
                  TextButton(
                      onPressed: () async {
                        if (pinController.text == _pin) {
                          Navigator.pushNamed(context, '/pin');
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'The PIN you entered is incorrect. Please try again',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Text(
                        'Enter',
                        style:
                            blueTextStyle.copyWith(fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget number(
    VoidCallback onTap,
    String number,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: darkRoyalBlue,
        ),
        child: Center(
          child: Text(
            number,
            style: whiteTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
