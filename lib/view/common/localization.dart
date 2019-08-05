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

  String get loginWithGoogle {
    return Intl.message(
      "Login with Google",
      name: "loginWithGoogle",
    );
  }

  String get logout {
    return Intl.message(
      "Log out",
      name: "logout",
    );
  }

  String get sortingOptions {
    return Intl.message(
      "Sorting options",
      name: "sortingOptions",
    );
  }

  String get sortAZ {
    return Intl.message("Title A-Z", name: "sortAZ");
  }

  String get sortZA {
    return Intl.message("Title Z-A", name: "sortZA");
  }

  String get sortNewest {
    return Intl.message("Newest First", name: "sortNewest");
  }

  String get sortOldest {
    return Intl.message("Oldest First", name: "sortOldest");
  }

  String get deleteBook {
    return Intl.message("Delete Book", name: "deleteBook");
  }

  String get changeLibrary {
    return Intl.message("Change Library", name: "changeLibrary");
  }

  String get selectLibrary {
    return Intl.message("Select Library", name: "selectLibrary");
  }

  String get loadingData {
    return Intl.message("Loading data", name: "loadingData");
  }

  String get bookMoved {
    return Intl.message("Book moved!", name: "bookMoved");
  }

  String get deleteBooksQuestion {
    return Intl.message("Delete books?", name: "deleteBooksQuestion");
  }

  String get deleteBookQuestion {
    return Intl.message("Delete book?", name: "deleteBookQuestion");
  }

  String get view {
    return Intl.message("View", name: "view");
  }

  String get bookAddedConfirm {
    return Intl.message("Book added to the library!", name: "bookAddedConfirm");
  }

  String get invalidISBN {
    return Intl.message("A valid ISBN should have 13 digits",
        name: "invalidISBN");
  }

  String get bookAlreadyPresent {
    return Intl.message("This book is already in the library",
        name: "bookAlreadyPresent");
  }

  String get save {
    return Intl.message("Save", name: "save");
  }

  String get cancel {
    return Intl.message("Cancel", name: "cancel");
  }

  String get confirm {
    return Intl.message("Yes", name: "confirm");
  }

  String get savingLibrary {
    return Intl.message("Saving library", name: "savingLibrary");
  }

  String get libraryName {
    return Intl.message("Library name", name: "libraryName");
  }

  String get favouriteLibrary {
    return Intl.message("Favourite library", name: "favouriteLibrary");
  }

  String get areYouSure {
    return Intl.message("Are you sure?", name: "areYouSure");
  }

  String get editLibrary {
    return Intl.message("Edit library", name: "editLibrary");
  }

  String get deleteLibrary {
    return Intl.message("Delete library", name: "deleteLibrary");
  }

  bookCount(n) {
    if (n == 0)
      return Intl.message("This library is empty", name: "bookCountZero");
    if (n == 1) return Intl.message("Contains one book", name: "bookCountOne");
    return Intl.message("Contains $n books", name: "bookCountMore");
  }

  String get deleteSelectedLibsConfirm {
    return Intl.message("Delete selected libraries?",
        name: "deleteSelectedLibsConfirm");
  }

  String get settings {
    return Intl.message("Settings", name: "settings");
  }

  String get wait {
    return Intl.message("Please wait...", name: "wait");
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
