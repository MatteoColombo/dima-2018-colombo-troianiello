import 'package:flutter_test/flutter_test.dart';
import 'package:dima2018_colombo_troianiello/model/author.model.dart';

void main() {
  test('Author empty', () {
    final author = Author();
    expect(author.name, null);
    expect(author.surname, null);
    expect(author.id, null);
    expect(author.isEmpty, true);
  });

  test('Author is not empty', () {
    final author = Author(
      name: 'a',
      surname: 'b',
    );
    expect(author.name, 'a');
    expect(author.surname, 'b');
  });

  test('Clear method', () {
    final author = Author(
      name: 'a',
      surname: 'b',
    );
    author.clear();
    expect(author.name, '');
    expect(author.surname, '');
    expect(author.isEmpty, true);
  });

  test('Clone method', () {
    final author = Author(
      name: 'a',
      surname: 'b',
    );
    Author author1=author.clone();
    expect(author.name==author1.name, true);
    expect(author.surname==author1.surname, true);
    expect(author.id==author1.id,true);
  });
}
