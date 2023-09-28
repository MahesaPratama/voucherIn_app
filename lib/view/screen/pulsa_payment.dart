// ignore_for_file: use_build_context_synchronously
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voucherin/ViewModel/pulsa_payment_provider.dart';
import 'package:voucherin/ViewModel/pulsa_product_provider.dart';
import 'package:voucherin/view/Widget/box_button.dart';
import 'package:voucherin/view/Widget/payment_method.dart';
import '../Theme/style.dart';

class PulsaPaymentPage extends StatefulWidget {
  final String? number;

  const PulsaPaymentPage({
    super.key,
    this.number,
  });

  @override
  State<PulsaPaymentPage> createState() => _PulsaPaymentPageState();
}

class _PulsaPaymentPageState extends State<PulsaPaymentPage> {
  num _saldo = 0;
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
  bool _isPinAvailable = false;
  final user = FirebaseAuth.instance.currentUser;

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

  triggerNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Payment Success',
            body: 'Hooray! You have completed your payment'));
  }

  Future addHistory({
    required String number,
    required String date,
    required String product,
    required String price,
    required String paymentMethod,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final docUser =
        FirebaseFirestore.instance.collection('${user!.email}').doc();
    final json = {
      'number': number,
      'date': date,
      'product': product,
      'price': price,
      'payment': paymentMethod,
    };
    await docUser.set(json);
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

  Future minSaldo({
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
  Widget build(BuildContext context) {
    final pulsaprovider = Provider.of<PulsaProductProvider>(context);
    final paymentprovider = Provider.of<PulsaPaymentProvider>(context);
    final String number = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Payment'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saldo',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              PayWidget(
                imageUrl: 'assets/logo.png',
                title: 'Saldo',
                size: 30,
                text: 'Rp $_saldo',
              ),
              Text(
                'Select Bank',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const PayWidget(imageUrl: 'assets/bca.png', title: 'BANK BCA'),
              const PayWidget(imageUrl: 'assets/bni.png', title: 'BANK BNI'),
              const PayWidget(
                  imageUrl: 'assets/mandiri.png', title: 'BANK MANDIRI'),
              const SizedBox(height: 15),
              Text(
                'Select E-Money',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const PayWidget(imageUrl: 'assets/Spay.png', title: 'ShopeePay'),
              const PayWidget(imageUrl: 'assets/Dana.png', title: 'Dana'),
              const PayWidget(imageUrl: 'assets/Ovo.png', title: 'Ovo'),
              BoxButton(
                label: 'BUY',
                labelStyle: whiteTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  var harga = num.parse(pulsaprovider.productPrice);
                  if (paymentprovider.paymentMethods == 'Saldo' &&
                      _saldo < harga) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Saldo anda tidak mencukupi untuk melanjutkan transaksi',
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(20),
                            height: 323,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Informasi Pelanggan',
                                  style: blackTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nomor Ponsel',
                                      style: blackTextStyle,
                                    ),
                                    Text(
                                      number,
                                      style: blackTextStyle,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: royalBlue,
                                  thickness: 2,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Detail Pembayaran',
                                  style: blackTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Produk",
                                      style: blackTextStyle,
                                    ),
                                    Text(
                                      pulsaprovider.productAmount,
                                      style: blackTextStyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Harga",
                                      style: blackTextStyle,
                                    ),
                                    Text(
                                      pulsaprovider.productPrice,
                                      style: blackTextStyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Metode Pembayaran",
                                      style: blackTextStyle,
                                    ),
                                    Text(
                                      paymentprovider.paymentMethods,
                                      style: blackTextStyle,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: royalBlue,
                                  thickness: 2,
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: blackTextStyle,
                                        )),
                                    BoxButton(
                                      label: 'Konfirmasi',
                                      labelStyle: whiteTextStyle,
                                      width: 120,
                                      onTap: () async {
                                        if (paymentprovider.paymentMethods ==
                                            'Saldo') {
                                          var input = num.parse(
                                              pulsaprovider.productPrice);
                                          setState(() {
                                            _saldo -= input;
                                          });
                                          pulsaprovider.setcurrentDate(cdate);
                                          await addHistory(
                                            number: number,
                                            date: pulsaprovider.currentDate,
                                            product:
                                                pulsaprovider.productAmount,
                                            price: pulsaprovider.productPrice,
                                            paymentMethod:
                                                paymentprovider.paymentMethods,
                                          );
                                          if (_isPinAvailable == true) {
                                            Navigator.pushNamed(
                                                context, '/pin_buy');
                                          } else {
                                            triggerNotification();
                                            Navigator.pushNamed(
                                                context, '/success');
                                          }
                                          minSaldo(saldo: _saldo);
                                        } else {
                                          pulsaprovider.setcurrentDate(cdate);
                                          await addHistory(
                                            number: number,
                                            date: pulsaprovider.currentDate,
                                            product:
                                                pulsaprovider.productAmount,
                                            price: pulsaprovider.productPrice,
                                            paymentMethod:
                                                paymentprovider.paymentMethods,
                                          );
                                          if (_isPinAvailable == true) {
                                            Navigator.pushNamed(
                                                context, '/pin_buy');
                                          } else {
                                            triggerNotification();
                                            Navigator.pushNamed(
                                                context, '/success');
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }
                },
                margin: const EdgeInsets.only(top: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
