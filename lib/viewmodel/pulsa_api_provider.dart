import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:voucherin/model/pulsa_api_model.dart';
import 'package:http/http.dart' as http;

class PulsaProvider with ChangeNotifier {
  Future<List<PulsaModel>> getPulsa() async {
    try {
      var response = await http.get(Uri.parse(
          'https://mocki.io/v1/d329e47e-c6c1-41da-acb2-666da894ef73'));
      if (response.statusCode == 200) {
        List<PulsaModel> pulsaProduct = [];
        List parsedJson = jsonDecode(response.body);
        // ignore: avoid_function_literals_in_foreach_calls
        parsedJson.forEach((pulsa) {
          pulsaProduct.add(PulsaModel.fromJson(pulsa));
        });
        return pulsaProduct;
      } else {
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }
}
