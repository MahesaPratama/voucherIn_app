import 'package:flutter/material.dart';

class PulsaProductProvider with ChangeNotifier {
  //Tanggal Pembelian
  String _currentDate = '';
  String get currentDate => _currentDate;

  void setcurrentDate(String index) {
    _currentDate = index;
    notifyListeners();
  }

  //Jumlah Produk
  String _productAmount = '';
  String get productAmount => _productAmount;

  void setproductAmount(String index) {
    _productAmount = index;
    notifyListeners();
  }

  //Harga Produk
  String _productPrice = '';
  String get productPrice => _productPrice;

  void setproductPrice(String index) {
    _productPrice = index;
    notifyListeners();
  }
}
