import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput {
  File _image;

  File get image {
    return _image;
  }

  Future<void> takePicture() async {
    final image = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxHeight: 2048,
      maxWidth: 2048,
    );

    if (image == null) {
      return;
    }

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);

    _image = await File(image.path).copy('${appDir.path}/$fileName');
    File(image.path).delete();
  }

  Future<void> pickFromGallery() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    _image = await File(image.path).copy('${appDir.path}/$fileName');
  }
}
