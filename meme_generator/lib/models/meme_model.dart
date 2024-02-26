import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_generator/modal_dialogs/show_picture_picker.dart';
import 'package:meme_generator/models/image_button_model.dart';
import 'package:meme_generator/models/image_model.dart';
import 'package:provider/provider.dart';

class MemeModel extends ChangeNotifier {
  String _memeUrl = 'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';
  String _memeText = '123';
  setMemeUrl(String url) {
    _memeUrl = url;
    notifyListeners();
  }

  String getMemeUrl() {
    return _memeUrl;
  }

  setMemeText(String text) {
    _memeText = text;
    notifyListeners();
  }

  getMemeText() {
    return _memeText;
  }

  initPicturePicker(BuildContext context) async {
    context.read<ImageModel>().assetFile.clear();
    context.read<ImageButtonModel>().assetFileSelect = List.generate(5555, (i) => false);
    context.read<ImageButtonModel>().isSelect();
    await context.read<ImageModel>().initAlbum();
    context.read<ImageModel>().loadImage();
    showPicturePicker(context);
  }
}
