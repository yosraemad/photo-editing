import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:photo_editing_app/src/database/database_helper.dart';
import 'package:photo_editing_app/src/logic/add_image_logic.dart';
import 'package:photo_editing_app/src/models/EditableImage.dart';
import 'package:photo_editing_app/src/models/Images.dart';
import 'package:provider/provider.dart';
import '../widgets/photo_grid.dart';

class GalleryScreen extends StatelessWidget {
  final AddImageLogic imageLogic = AddImageLogic();
  final DataBaseHelper dataBaseHelper = DataBaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<Images>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: PhotosGrid(),
      floatingActionButton: SpeedDial(
        closeManually: false,
        child: Icon(Icons.add),
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Add a photo',
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera),
            backgroundColor: Colors.black,
            onTap: () async {
              final loadedImage = await imageLogic.getImageUsingCamera();
              if (loadedImage != null) {
                EditableImage image = EditableImage(image: loadedImage);
                imageProvider.addImage(image);
                dataBaseHelper.insert(image);
              }
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.photo),
            backgroundColor: Colors.black,
            onTap: () async {
              final loadedImage = await imageLogic.getImageUsingGallery();
              EditableImage image = EditableImage(image: loadedImage);
              if (loadedImage != null)
              {imageProvider.addImage(image);
              dataBaseHelper.insert(image);}
            },
          ),
        ],
      ),
    );
  }
}
