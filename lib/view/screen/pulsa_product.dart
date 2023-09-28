import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:voucherin/model/pulsa_api_model.dart';
import 'package:voucherin/ViewModel/pulsa_api_provider.dart';
import 'package:voucherin/view/Widget/box_button.dart';
import 'package:voucherin/view/Widget/product_price.dart';
import '../Theme/style.dart';

class PulsaProductPage extends StatefulWidget {
  const PulsaProductPage({super.key});

  @override
  State<PulsaProductPage> createState() => _PulsaProductPageState();
}

class _PulsaProductPageState extends State<PulsaProductPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pulsaProvider = Provider.of<PulsaProvider>(context);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Pulsa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
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
                      hintText: 'Masukkan nomor telepon anda',
                      suffixIcon: Icon(
                        FontAwesome.circle_user,
                        color: darkRoyalBlue,
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a number';
                    } else if (value.length < 10 || value.length > 13) {
                      return 'Number must be between 10 and 13';
                    }
                    return null;
                  },
                  controller: numberController,
                ),
                const SizedBox(height: 30),
                FutureBuilder<List<PulsaModel>>(
                    future: pulsaProvider.getPulsa(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 11,
                            crossAxisSpacing: 11,
                          ),
                          shrinkWrap: true,
                          children: snapshot.data!
                              .map((pulsa) => PriceWidget(
                                  produk: pulsa.productAmount.toString(),
                                  harga: pulsa.productPrice.toString()))
                              .toList(),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: royalBlue,
                        ),
                      );
                    }),
                BoxButton(
                  label: 'Continue',
                  labelStyle: whiteTextStyle,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      Navigator.pushNamed(context, '/payment',
                          arguments: numberController.text);
                    }
                  },
                  margin: const EdgeInsets.only(top: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
