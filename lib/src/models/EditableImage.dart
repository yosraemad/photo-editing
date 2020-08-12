import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as i;

class EditableImage with ChangeNotifier {
  final String columnImage = "_image";
  final String tableImages = "images";
  final String columnSaturation = "_saturation";
  final String columnContrast = "_contrast";
  final String columnBrightness = "_brightness";

  String imageLocation;
  double saturation;
  double contrast;
  double brightness;
  i.Image decodedImage;
  i.Image modifiedImage;

  EditableImage({
    @required this.imageLocation,
    this.saturation,
    this.contrast,
    this.brightness,
  }) {
    decodedImage = getImage(imageLocation);
    modifiedImage = decodedImage;
  }

  EditableImage.fromMap(Map<String, dynamic> map) {
    imageLocation = map[columnImage];
    saturation = map[columnSaturation];
    contrast = map[columnContrast];
    brightness = map[columnBrightness];

    decodedImage = getImage(imageLocation);
    modifiedImage = decodedImage;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnImage: imageLocation,
      columnSaturation: saturation,
      columnContrast: contrast,
      columnBrightness: brightness
    };
  }

  EditableImage changeBrightness(double value) {
    brightness = value;
    modifiedImage = getImage(imageLocation);
    modifiedImage = i.adjustColor(modifiedImage, brightness: 55);
    notifyListeners();
    return this;
  }

  void changeSaturation(double value) {
    saturation = value;
    notifyListeners();
  }

  void changeContrast(double value) {
    contrast = value;
    notifyListeners();
  }

  i.Image getImage(String path) {
    return i.decodeImage(File(path).readAsBytesSync());
  }

  File get image =>
      File("$imageLocation")..writeAsBytesSync(i.encodeJpg(modifiedImage));
  i.Image get originalImage => decodedImage;
}
