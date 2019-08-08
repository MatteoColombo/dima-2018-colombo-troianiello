import 'package:dima2018_colombo_troianiello/interfaces/base-scanner.dart';
import 'package:dima2018_colombo_troianiello/view/common/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanner extends BaseScanner {
  @override
  Future<String> getISBN(BuildContext context) async {
    return FlutterBarcodeScanner.scanBarcode(
      "#ffffff",
      Localization.of(context).cancel,
      true,
    );
  }
}
