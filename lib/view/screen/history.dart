import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:voucherin/model/firestore_history_model.dart';
import 'package:voucherin/view/Theme/style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final user = FirebaseAuth.instance.currentUser;
  Stream<List<History>> readUsers() => FirebaseFirestore.instance
      .collection('${user!.email}')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => History.fromJson(doc.data())).toList());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: StreamBuilder<List<History>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildUser(History history) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.grey,
      )),
      child: ListTile(
        leading: Icon(
          IonIcons.phone_portrait,
          color: royalBlue,
        ),
        title: Text(
          history.number,
          style: blackTextStyle,
        ),
        subtitle: Text(
          history.date,
          style: blackTextStyle,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              history.product,
              style: blackTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            Text(
              'Rp${history.price}',
              style: blackTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            Text(
              history.paymentMethod,
              style: blackTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
