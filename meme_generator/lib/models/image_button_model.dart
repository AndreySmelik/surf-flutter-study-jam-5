import 'package:flutter/material.dart';

class ImageButtonModel extends ChangeNotifier {
  List<bool> assetFileSelect = [];
  List<String> dropDownListFormResult = [];
  bool fileSelect = false;

  isSelect() {
    fileSelect = !assetFileSelect.every((element) => element == false);
    notifyListeners();
  }

  modelRebuild() {
    notifyListeners();
  }
}