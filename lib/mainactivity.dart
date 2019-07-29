import 'package:flutter/material.dart';
import './firebase/auth.dart';
import './view/library/library-list.dart';
import './view/book/book.dart';
import './view/addbook/add-book.dart';

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dima 2018"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            MaterialButton(
              child: Text("Librerie"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LibraryList())),
            ),
            MaterialButton(
              child: Text("Nuovo libro"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBook())),
            ),
            MaterialButton(
              child: Text("Libro"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookPage(
                            isbn: '9781401242152',
                            //'9788804711957',
                            //'0',
                            addBook: false,
                          ))),
            ),
            MaterialButton(
              child: Text("Sign out"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => authService.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
