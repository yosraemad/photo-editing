import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_editing_app/src/enum/selected_option_enum.dart';
import 'package:photo_editing_app/src/models/EditableImage.dart';
import 'package:photo_editing_app/src/models/Images.dart';
import 'package:photo_editing_app/src/widgets/popup.dart';
import 'package:provider/provider.dart';

class EditingScreen extends StatefulWidget {
  static final routeName = "/editing-screen";

  @override
  EditingScreenState createState() => EditingScreenState();
}

class EditingScreenState extends State<EditingScreen> {
  SelectedOption _selectedOption;
  EditableImage image;

  static EditingScreenState of(BuildContext context) {
    final EditingScreenState navigator =
        context.findAncestorStateOfType<EditingScreenState>();
    return navigator;
  }

  @override
  void initState() {
    _selectedOption = SelectedOption.NULL;
    super.initState();
  }

  void changeOption(SelectedOption selectedOption) {
    if (_selectedOption == selectedOption)
      setState(() {
        _selectedOption = SelectedOption.NULL;
      });
    else {
      setState(() {
        _selectedOption = SelectedOption.NULL;
      });
      setState(() {
        _selectedOption = selectedOption;
      });
    }
  }

  void setValue(double value) {
    setState(() {
      if (_selectedOption == SelectedOption.BRIGHTNESS)
        image = image.changeBrightness(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoIndex = ModalRoute.of(context).settings.arguments;
    image = Provider.of<Images>(context).getImagebyId(photoIndex);
    return ChangeNotifierProvider<EditableImage>.value(
      value: image,
          child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)},
              color: Colors.white,
            ),
            backgroundColor: Colors.grey[900],
            shadowColor: Colors.white,
            title: Text(
              "Edit Image",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 450,
                child: Consumer<EditableImage>(
                    builder:(context,image,_) => Align(child: Image.file(image.image),
                  ),
                ),
              ),
              _slider(_selectedOption),
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  splashRadius: 0.01,
                  icon: Icon(Icons.brightness_6),
                  color: Colors.white,
                  onPressed: () => {changeOption(SelectedOption.BRIGHTNESS)},
                  tooltip: "brightness",
                ),
                IconButton(
                  splashRadius: 0.01,
                  icon: Icon(Icons.tonality),
                  color: Colors.white,
                  onPressed: () => {changeOption(SelectedOption.CONTRAST)},
                  tooltip: "contrast",
                ),
                IconButton(
                  splashRadius: 0.01,
                  icon: Icon(Icons.color_lens),
                  color: Colors.white,
                  onPressed: () => {changeOption(SelectedOption.SATURATION)},
                  tooltip: "saturation",
                )
              ],
            ),
          )),
    );
  }

  Widget _slider(SelectedOption selectedOption) {
    if (selectedOption == SelectedOption.NULL)
      return Container();
    else if (selectedOption == SelectedOption.BRIGHTNESS) {
      return Popup(0.5);
    } else if (selectedOption == SelectedOption.CONTRAST) {
      return Popup(0);
    } else if (selectedOption == SelectedOption.SATURATION) {
      return Popup(0.5);
    } else {
      return Container();
    }
  }
}
