import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucherin/ViewModel/pulsa_payment_provider.dart';

import '../Theme/style.dart';

class PayWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double size;
  final String text;
  const PayWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    this.size = 65,
    this.text = '60 min',
  });

  @override
  Widget build(BuildContext context) {
    final pulsapaymentprovider = Provider.of<PulsaPaymentProvider>(context);
    bool isSelected = pulsapaymentprovider.paymentMethods == title;
    return GestureDetector(
      onTap: () {
        pulsapaymentprovider.setpaymentMethods(title);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: isSelected == true ? darkRoyalBlue : Colors.white,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              imageUrl,
              width: size,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                    )),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: blackTextStyle.copyWith(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
