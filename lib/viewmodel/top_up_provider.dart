import 'package:flutter/material.dart';

class TopUpProvider with ChangeNotifier {
  String _topUp = '';
  String get topUp => _topUp;

  void settopUp(String index) {
    _topUp = index;
    notifyListeners();
  }
}
