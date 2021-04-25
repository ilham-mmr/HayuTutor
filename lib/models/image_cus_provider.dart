import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class ImageCusProvider with ChangeNotifier {
  String _base64Image = '';

  Future<void> setImage(File image) async {
    if (image == null) {
      _base64Image = '';
      notifyListeners();
      return;
    }
    String base64Image = base64Encode(image.readAsBytesSync());
    _base64Image = base64Image;
    notifyListeners();
  }

  String get base64Image {
    return _base64Image;
  }
}
