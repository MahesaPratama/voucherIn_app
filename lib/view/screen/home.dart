import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voucherin/view/Theme/style.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  num _saldo = 0;
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

  @override
  void initState() {
    super.initState();
    _getPin();
    _getSaldo();
  }

  @override
  Widget build(BuildContext context) {
    //Mengatur ukuran menjadi adaptive
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Hello\n${user!.email}'),
        centerTitle: false,
        backgroundColor: royalBlue,
        titleTextStyle: whiteTextStyle.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: menu(() {
                FirebaseAuth.instance.signOut();
                Navigator.restorablePushNamedAndRemoveUntil(
                    context, '/start', (route) => false);
              }, 'Logout')),
              PopupMenuItem(
                  child: menu(() {
                _isPinAvailable == true
                    ? Navigator.pushNamed(context, '/pin_confirm')
                    : Navigator.pushNamed(context, '/pin');
              }, 'Pin')),
              PopupMenuItem(
                  child: menu(() {
                Navigator.pushNamed(context, '/cs');
              }, 'Contact Us'))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          //Keterangan Saldo
          Container(
            padding: EdgeInsets.only(
              bottom: h / 20,
              right: w / 20,
              left: w / 20,
            ),
            height: h / 5,
            color: royalBlue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: darkRoyalBlue,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      child: ListTile(
                        leading: const Icon(
                          LineAwesome.coins_solid,
                          color: Color.fromARGB(225, 255, 255, 255),
                          size: 35,
                        ),
                        title: Text('Saldo Mitra', style: whiteTextStyle),
                        subtitle: Text('Rp $_saldo',
                            style: whiteTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/saldo');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              'ISI SALDO',
                              style: whiteTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.only(top: h / 6),
            width: double.infinity,
            decoration: BoxDecoration(
                color: background,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(
              children: [
                //Untuk Promo
                CarouselSlider(
                  items: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const Image(
                        width: double.infinity,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://img.freepik.com/premium-vector/flash-sale-background-with-discount_666566-14.jpg?w=740'),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                  ),
                ),
                const SizedBox(height: 15),
                //Produk Yang Dijual
                GridView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 3,
                  ),
                  children: [
                    produk(
                      IonIcons.phone_portrait,
                      'Pulsa',
                      () {
                        Navigator.pushNamed(context, '/pulsa');
                      },
                    ),
                    produk(
                      IonIcons.wifi,
                      'Paket Data',
                      () {},
                    ),
                    produk(
                      IonIcons.bulb,
                      'Listrik PLN',
                      () {},
                    ),
                    produk(
                      IonIcons.ticket,
                      'Voucher Game',
                      () {},
                    ),
                    produk(
                      IonIcons.medical,
                      'BPJS',
                      () {},
                    ),
                    produk(
                      FontAwesome.square_phone,
                      'Telkom',
                      () {},
                    ),
                    produk(
                      IonIcons.water,
                      'PDAM',
                      () {},
                    ),
                    produk(
                      IonIcons.tv_sharp,
                      'TV Kabel',
                      () {},
                    ),
                    produk(
                      FontAwesome.money_bill_transfer,
                      'Kirim Uang',
                      () {},
                    ),
                    produk(
                      IonIcons.home,
                      'PBB',
                      () {},
                    ),
                    produk(
                      FontAwesome.fire,
                      'PGN',
                      () {},
                    ),
                    produk(
                      FontAwesome.train_subway,
                      'Tiket Kereta',
                      () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  //Custom Widget Daftar Produk
  Widget produk(
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(height: MediaQuery.of(context).size.height / 65),
          Text(
            label,
            style: blackTextStyle,
          )
        ],
      ),
    );
  }

  Widget menu(
    VoidCallback onTap,
    String label,
  ) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: blackTextStyle.copyWith(fontSize: 16),
      ),
    );
  }
}
