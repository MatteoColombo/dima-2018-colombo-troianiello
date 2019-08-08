import 'dart:io';

abstract class BasePicker {
  Future<File> getImage();
}
