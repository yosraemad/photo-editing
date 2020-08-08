import 'package:flutter/material.dart';

class EditableImage with ChangeNotifier {
  final String columnImage = "_image";
  final String tableImages = "images";
  final String columnSaturation = "_saturation";
  final String columnContrast = "_contrast";
  final String columnBrightness = "_brightness";

  String image;
  double saturation;
  double contrast;
  double brightness;

  EditableImage({
    @required this.image,
    this.saturation,
    this.contrast,
    this.brightness,
  });

  EditableImage.fromMap(Map<String, dynamic> map) {
    image = map[columnImage];
    saturation = map[columnSaturation];
    contrast = map[columnContrast];
    brightness = map[columnBrightness];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnImage: image,
      columnSaturation: saturation,
      columnContrast: contrast,
      columnBrightness: brightness
    };
  }
}
