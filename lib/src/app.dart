import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/Images.dart';
import 'screens/gallery_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Images(),
      child: MaterialApp(
        home: GalleryScreen(),
        theme: ThemeData(
          accentColor: Colors.black,
          primaryColor: Colors.white,
        ),
        routes: {
          // GalleryScreen.routeName: (context) => GalleryScreen(),
        },
      ),
    );
  }
}
