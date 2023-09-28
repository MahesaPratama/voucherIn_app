import 'package:flutter/material.dart';
import 'package:voucherin/view/Theme/style.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> sendEmail() async {
    final Email email = Email(
      body: messageController.text,
      recipients: ['68pratama@gmail.com'],
    );
    await FlutterEmailSender.send(email);
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 300,
              color: royalBlue,
              child: const Center(
                  child: Image(
                image: AssetImage('assets/cs.png'),
                height: 300,
              )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 270, left: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 400,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'How can we help you?',
                    style: blueTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'It looks like you have problems with our system.\nWe are ere to help you, so, please get in touch with us.',
                    textAlign: TextAlign.center,
                    style: blueTextStyle,
                  ),
                  const SizedBox(height: 35),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: messageController,
                      maxLines: 8,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pesan tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                            )),
                        hintText: 'Type your message...',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 640),
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        sendEmail();
                      }
                    },
                    child: const Image(
                      image: AssetImage('assets/send.png'),
                      height: 65,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
