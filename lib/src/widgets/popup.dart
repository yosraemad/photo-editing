import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:photo_editing_app/src/screens/editing_screen.dart';

class Popup extends StatefulWidget {
  final double initialValue;
  Popup(this.initialValue);
  @override
  State<StatefulWidget> createState() => PopupState();
}

class PopupState extends State<Popup> with SingleTickerProviderStateMixin {
  double _sliderValue;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    _sliderValue = widget.initialValue;

    controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    animation = Tween<double>(begin: 50.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
    controller.addListener(() => setState(() {}));
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EditingScreenState editingScreenState = EditingScreenState.of(context);
    return Transform.translate(
      offset: Offset(0.0, animation.value),
      child: Container(
        padding: EdgeInsets.only(top: 12),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text("BRIGHTNESS",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Slider(
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  this._sliderValue = value;
                });
              },
              onChangeEnd: (double val) {
                setState(() {
                  editingScreenState.setValue(value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  double get value => _sliderValue;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
