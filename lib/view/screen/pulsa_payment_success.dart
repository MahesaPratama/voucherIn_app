import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:voucherin/view/Theme/style.dart';
import 'package:voucherin/view/Widget/box_button.dart';
import 'package:animation_wrappers/animation_wrappers.dart';

class PulsaPaymentSuccessPage extends StatelessWidget {
  const PulsaPaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAnimation(
        duration: const Duration(milliseconds: 2500),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesome.circle_check,
                  color: Colors.white,
                  size: 90,
                ),
                const SizedBox(height: 30),
                Text(
                  'Payment successfully \ncompleted',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(height: 15),
                BoxButton(
                  label: 'Back to Home',
                  labelStyle: blueTextStyle,
                  width: 180,
                  margin: const EdgeInsets.only(top: 15),
                  buttonColor: Colors.white,
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/navbar', (route) => false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
