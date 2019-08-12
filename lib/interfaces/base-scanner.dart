
import 'package:flutter/material.dart';

abstract class BaseScanner {
  Future<String> getISBN(BuildContext context);
}
