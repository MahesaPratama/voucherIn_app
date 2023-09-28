import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:voucherin/view/Theme/style.dart';
class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
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

  @override
  void dispose() {
    super.dispose();
    pinController.dispose();
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
                'Enter Your 6 Digit Pin',
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
                      onPressed: () {
                        if (pinController.text.length == 6) {
                          Navigator.restorablePushNamedAndRemoveUntil(
                            context,
                            '/create_confirm',
                            (route) => false,
                            arguments: pinController.text,
                          );
                        }
                      },
                      child: Text(
                        'Continue',
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
