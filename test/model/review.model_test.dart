import 'package:flutter_test/flutter_test.dart';
import 'package:dima2018_colombo_troianiello/model/review.model.dart';

void main() {
  test('Review is empty', () {
    final review = Review();
    expect(review.score, 1);
    expect(review.user, null);
    expect(review.userId, null);
    expect(review.text, null);
    expect(review.date, null);
    expect(review.isEmpty(), true);
  });
}
