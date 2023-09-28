import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:voucherin/view/Theme/style.dart';
import 'package:voucherin/view/Widget/box_button.dart';

import '../Widget/top_up_method.dart';

class SaldoPage extends StatefulWidget {
  const SaldoPage({super.key});

  @override
  State<SaldoPage> createState() => _SaldoPageState();
}

class _SaldoPageState extends State<SaldoPage> {
  num _saldo = 0;
  bool _isPinAvailable = false;
  final _formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController numberController = TextEditingController();

  void _getPin() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('${user?.email} PIN')
        .doc('user_pin')
        .get();
    if (snapshot.exists) {
      setState(() {
        _isPinAvailable = true;
      });
    }
  }

  void _getSaldo() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('${user?.email} Saldo')
        .doc('user_saldo')
        .get();
    if (snapshot.exists) {
      num saldo = snapshot.get('saldo');
      setState(() {
        _saldo = saldo;
      });
    }
  }

  Future addSaldo({
    required num saldo,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final docUser = FirebaseFirestore.instance
        .collection('${user!.email} Saldo')
        .doc('user_saldo');
    final json = {
      'saldo': saldo,
    };
    await docUser.set(json);
  }

  @override
  void initState() {
    super.initState();
    _getPin();
    _getSaldo();
  }

  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        fillColor: lightRoyalBlue.withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Masukkan nominal top up',
                        suffixIcon: Icon(
                          FontAwesome.money_bill,
                          color: darkRoyalBlue,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a number';
                      } else if (value.length < 4) {
                        return 'Minimal harus seribu';
                      }
                      return null;
                    },
                    controller: numberController,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Select Bank',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TopUpWidget(
                      imageUrl: 'assets/bca.png', title: 'BANK BCA'),
                  const TopUpWidget(
                      imageUrl: 'assets/bni.png', title: 'BANK BNI'),
                  const TopUpWidget(
                      imageUrl: 'assets/mandiri.png', title: 'BANK MANDIRI'),
                  const SizedBox(height: 15),
                  Text(
                    'Select E-Money',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TopUpWidget(
                      imageUrl: 'assets/Spay.png', title: 'ShopeePay'),
                  const TopUpWidget(imageUrl: 'assets/Dana.png', title: 'Dana'),
                  const TopUpWidget(imageUrl: 'assets/Ovo.png', title: 'Ovo'),
                  const SizedBox(height: 20),
                  BoxButton(
                    label: 'Top Up',
                    labelStyle: whiteTextStyle,
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        var input = num.parse(numberController.text);
                        setState(() {
                          _saldo += input;
                        });
                        addSaldo(saldo: _saldo);
                        if (_isPinAvailable == true) {
                          Navigator.pushNamed(context, '/pin_buy');
                        } else {
                          Navigator.pushNamed(context, '/success');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
