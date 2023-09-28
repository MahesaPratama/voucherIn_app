// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucherin/ViewModel/pulsa_product_provider.dart';

import '../theme/style.dart';

class PriceWidget extends StatelessWidget {
  final String produk;
  final String harga;

  const PriceWidget({
    super.key,
    required this.produk,
    required this.harga,
  });

  @override
  Widget build(BuildContext context) {
    final pulsaprovider = Provider.of<PulsaProductProvider>(context);
    bool isSelected1 = pulsaprovider.productAmount == produk;
    bool isSelected2 = pulsaprovider.productPrice == harga;
    return GestureDetector(
      onTap: () {
        pulsaprovider.setproductAmount(produk);
        pulsaprovider.setproductPrice(harga);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected1 == true ? darkRoyalBlue : Colors.white,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              produk,
              style: blackTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              'Rp $harga',
              style: blackTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
