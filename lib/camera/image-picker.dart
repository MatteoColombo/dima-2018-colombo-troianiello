import 'dart:io';

import 'package:dima2018_colombo_troianiello/interfaces/base-picker.dart';
import 'package:image_picker/image_picker.dart';

class ImgPicker extends BasePicker {
  @override
  Future<File> getImage(double width, double height, ImageSource type) async {
    return ImagePicker.pickImage(
      source: type,
      maxHeight: height,
      maxWidth: width,
    );
  }
}
