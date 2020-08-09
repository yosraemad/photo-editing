import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_editing_app/src/models/EditableImage.dart';
import 'package:photo_editing_app/src/models/Images.dart';
import 'package:photo_editing_app/src/screens/editing_screen.dart';
import 'package:provider/provider.dart';

class PhotosGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final images = Provider.of<Images>(context).images;
    return FutureBuilder<List<EditableImage>>(
      future: images,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return GridView.builder(
            itemCount: snapshot.data.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => Navigator.pushNamed(context, EditingScreen.routeName, arguments: index),
              child: Container(
                child:Image.file(File(snapshot.data[index].image)),
                padding: EdgeInsets.all(10),
              ),
            ),
            
          );
        else if (snapshot.hasError)
          return Center(
            child: Text("Error loading data :("),
          );
        else
          return CircularProgressIndicator();
      },
    );
  }
}
