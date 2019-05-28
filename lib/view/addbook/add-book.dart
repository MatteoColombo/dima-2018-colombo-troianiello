import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddBook extends StatefulWidget {

  @override 
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _isbnController;

  _AddBookState() {
    _isbnController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Aggiungi libro alla collezione"),
    );
  }

  _saveBook() {}

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: TextFormField(
            controller: _isbnController,
            decoration: InputDecoration(
              labelText: "Isbn code",
              hintText: "e.g. 1234567890123"
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _scanBarcode(),
          ),
        ),
      ],
    );
  }

  _scanBarcode() async {
    try {
      String barcodeScanRes =
          await FlutterBarcodeScanner.scanBarcode("#ffffff", "Annulla", false); 
      if (barcodeScanRes.length > 0) {
        setState(() {
          _isbnController.text = barcodeScanRes;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
