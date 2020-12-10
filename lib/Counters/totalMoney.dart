import 'package:flutter/foundation.dart';

class TotalAmount extends ChangeNotifier{
  double _totalAmount = 0;
  double get totalAmount => _totalAmount;

  displayResult(double no) async{
    _totalAmount = no;

    await Future.delayed(const Duration(milliseconds: 100), (){
      notifyListeners();
    });

  }
}