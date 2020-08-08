import 'package:image_picker/image_picker.dart';

class AddImageLogic {
  final picker = ImagePicker();

  Future<String> getImageUsingGallery() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      return pickedFile.path;
    } catch (e) {
      return null;
    }
  }

  Future<String> getImageUsingCamera() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      return pickedFile.path;
    } catch (e) {
      return null;
    }
  }
}
