import 'package:flutter/material.dart';

class Popup extends StatefulWidget {
  final double initialValue;
  Popup(this.initialValue);
  @override
  State<StatefulWidget> createState() => PopupState();
}

class PopupState extends State<Popup> {
  double _sliderValue;
  @override
  void initState() {
    _sliderValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Slider(
        value: _sliderValue,
        onChanged: (double val) {
          setState(() {
            this._sliderValue = val;
          });
        },
      ),
    );
  }

  double get value => _sliderValue;
}
