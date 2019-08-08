import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class BasePicker {
  Future<File> getImage(double width, double height, ImageSource type);
}
