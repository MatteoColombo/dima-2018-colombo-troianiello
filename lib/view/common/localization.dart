import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/messages_all.dart';

class Localization {
  static Future<Localization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return Localization();
    });
  }

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String get title {
    return Intl.message(
      'Title',
      name: 'title',
    );
  }

  String get description {
    return Intl.message(
      'Description',
      name: 'description',
    );
  }

  String get authors {
    return Intl.message(
      'Authors',
      name: 'authors',
    );
  }

  String get releaseDate {
    return Intl.message(
      'Release date',
      name: 'releaseDate',
    );
  }

  String get publisher {
    return Intl.message(
      'Publisher',
      name: 'publisher',
    );
  }

  String get pages {
    return Intl.message(
      'Pages',
      name: 'pages',
    );
  }

  String get edition {
    return Intl.message(
      'Edition',
      name: 'edition',
    );
  }

  String get price {
    return Intl.message(
      'Price',
      name: 'price',
    );
  }

  String get showMore {
    return Intl.message(
      'Show more',
      name: 'showMore',
    );
  }

  String get showLess {
    return Intl.message(
      'Show less',
      name: 'showLess',
    );
  }

  String get isbn {
    return Intl.message(
      'ISBN',
      name: 'isbn',
    );
  }

  String get authorErrorMessage {
    return Intl.message(
      'Author must have a name and a surname',
      name: 'authorErrorMessage',
    );
  }

  String get name {
    return Intl.message(
      'Name',
      name: 'name',
    );
  }

  String get surname {
    return Intl.message(
      'Surname',
      name: 'surname',
    );
  }

  String get fieldError {
    return Intl.message(
      'This field cannot be empty',
      name: 'fieldError',
    );
  }

  String get priceError {
    return Intl.message(
      'Pages must be a number',
      name: 'priceError',
    );
  }

  String get done {
    return Intl.message(
      'Done',
      name: 'done',
    );
  }

  String get suggestChanges {
    return Intl.message(
      'Suggest changes',
      name: 'suggestChanges',
    );
  }

  String get labelTakePhoto {
    return Intl.message(
      'Take a photo',
      name: 'labelTakePhoto',
    );
  }

  String get labelLoadImg {
    return Intl.message(
      'Load a image',
      name: 'labelLoadImg',
    );
  }

  String get review {
    return Intl.message(
      'Your review',
      name: 'review',
    );
  }

  String get otherReviews {
    return Intl.message(
      'Other reviews',
      name: 'otherReviews',
    );
  }

  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
    );
  }

  String get allReviews {
    return Intl.message(
      'All',
      name: 'allReviews',
    );
  }

  String get hintReview {
    return Intl.message(
      'Write a review',
      name: 'hintReview',
    );
  }

  String get error {
    return Intl.message(
      'Error',
      name: 'error',
    );
  }

  String get close {
    return Intl.message(
      'Close',
      name: 'close',
    );
  }

  String get insertImage {
    return Intl.message(
      'Insert image',
      name: 'insertImage',
    );
  }

  String get savingInformations {
    return Intl.message(
      'Saving the informations',
      name: 'savingInformations',
    );
  }

  String get addNewBook {
    return Intl.message(
      'Add new book',
      name: 'addNewBook',
    );
  }
}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'it'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => Localization.load(locale);

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
