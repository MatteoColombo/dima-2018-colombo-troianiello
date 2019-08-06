import 'package:flutter_test/flutter_test.dart';
import 'package:dima2018_colombo_troianiello/model/book.model.dart';
import 'package:dima2018_colombo_troianiello/model/author.model.dart';

void main() {
  test('Book empty', () {
    final book = Book();
    expect(book.isbn, null);
    expect(book.description, null);
    expect(book.pages, null);
    expect(book.price, null);
    expect(book.publisher, null);
    expect(book.title, null);
    expect(book.releaseDate!=null,true);
    expect(book.authors.length, 0);
    expect(book.toCheck, true);
    expect(book.isEmpty(), true);
  });
  test('Book not empty', () {
    final book = Book(
      title: 'title',
      description: 'desc',
      edition: 'ed',
      image: 'url',
      isbn: '000',
      pages: 10,
      price: '10',
      publisher: 'pub',
      releaseDate: DateTime.utc(1970,12,20),
    );
    expect(book.isbn, '000');
    expect(book.description, 'desc');
    expect(book.pages, 10);
    expect(book.price, '10');
    expect(book.publisher, 'pub');
    expect(book.title, 'title');
    expect(book.releaseDate==DateTime.utc(1970,12,20),true);
    expect(book.authors.length, 0);
    expect(book.toCheck, true);
    expect(book.isEmpty(), false);
  });

  test('Add and remove methods', () {
    final book = Book();
    Author author= Author();
    author.name='Name';
    author.surname='Surname';
    book.addAuthor(author);
    expect(book.authors.first, author);
    book.addAuthor(new Author());
    expect(book.authors.length, 2);
    book.deleteAuthor(author);
    expect(book.authors.length, 1);
    expect(book.authors.contains(author),false);
  });

  test('Clone method', () {
    final book = Book(
      title: 'title',
      description: 'desc',
      edition: 'ed',
      image: 'url',
      isbn: '000',
      pages: 10,
      price: '10',
      publisher: 'pub',
      releaseDate: DateTime.utc(1970,12,20),
    );
    Book book1=book.clone();
    expect(book.isbn==book1.isbn, true);
    expect(book.description==book1.description, true);
    expect(book.edition==book1.edition, true);
    expect(book.image==book1.image, true);
    expect(book.pages==book1.pages, true);
    expect(book.title==book1.title, true);
    expect(book.toCheck==book1.toCheck, true);
    expect(book.releaseDate==book1.releaseDate, true);
    expect(book.publisher==book1.publisher, true);
  });
}
