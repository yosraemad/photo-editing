import 'package:flutter/material.dart';
import 'package:photo_editing_app/src/database/database_helper.dart';
import 'package:photo_editing_app/src/models/EditableImage.dart';

class Images with ChangeNotifier {
  List<EditableImage> _images = [];
  DataBaseHelper _dataBaseHelper = DataBaseHelper.instance;

  Future<List<EditableImage>> get images async {
    _images = await _dataBaseHelper.getAllImages();
    return _images;
  }

  void addImage(EditableImage image) {
    _images.add(image);
    notifyListeners();
  }

  EditableImage getImagebyId(int id) {
    return _images[id];
  }
}
