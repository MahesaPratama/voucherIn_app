import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucherin/ViewModel/top_up_provider.dart';

import '../Theme/style.dart';

class TopUpWidget extends StatelessWidget {
  final String imageUrl;
  final String title;

  const TopUpWidget({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final topup = Provider.of<TopUpProvider>(context);
    bool isSelected = topup.topUp == title;
    return GestureDetector(
      onTap: () {
        topup.settopUp(title);
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
              width: 85,
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
                  '50 min',
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
