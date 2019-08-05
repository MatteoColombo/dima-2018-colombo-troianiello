// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  static m0(n) => "${Intl.plural(n, zero: 'This library is empty', one: 'Contains one book', other: 'Contains ${n} books')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addNewBook" : MessageLookupByLibrary.simpleMessage("Add new book"),
    "allReviews" : MessageLookupByLibrary.simpleMessage("All"),
    "areYouSure" : MessageLookupByLibrary.simpleMessage("Are you sure?"),
    "authorErrorMessage" : MessageLookupByLibrary.simpleMessage("Author must have a name and a surname"),
    "authors" : MessageLookupByLibrary.simpleMessage("Authors"),
    "bookAddedConfirm" : MessageLookupByLibrary.simpleMessage("Book added to the library!"),
    "bookAlreadyPresent" : MessageLookupByLibrary.simpleMessage("This book is already in the library"),
    "bookCount" : m0,
    "bookMoved" : MessageLookupByLibrary.simpleMessage("Book moved!"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "changeLibrary" : MessageLookupByLibrary.simpleMessage("Change Library"),
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Yes"),
    "deleteBook" : MessageLookupByLibrary.simpleMessage("Delete Book"),
    "deleteBookQuestion" : MessageLookupByLibrary.simpleMessage("Delete book?"),
    "deleteBooksQuestion" : MessageLookupByLibrary.simpleMessage("Delete books?"),
    "deleteLibrary" : MessageLookupByLibrary.simpleMessage("Delete library"),
    "deleteSelectedLibsConfirm" : MessageLookupByLibrary.simpleMessage("Delete selected libraries?"),
    "description" : MessageLookupByLibrary.simpleMessage("Description"),
    "done" : MessageLookupByLibrary.simpleMessage("Done"),
    "editLibrary" : MessageLookupByLibrary.simpleMessage("Edit library"),
    "edition" : MessageLookupByLibrary.simpleMessage("Edition"),
    "error" : MessageLookupByLibrary.simpleMessage("Error"),
    "favouriteLibrary" : MessageLookupByLibrary.simpleMessage("Favourite library"),
    "fieldError" : MessageLookupByLibrary.simpleMessage("This field cannot be empty"),
    "hintReview" : MessageLookupByLibrary.simpleMessage("Write a review"),
    "insertImage" : MessageLookupByLibrary.simpleMessage("Insert image"),
    "invalidISBN" : MessageLookupByLibrary.simpleMessage("A valid ISBN should have 13 digits"),
    "isbn" : MessageLookupByLibrary.simpleMessage("ISBN"),
    "labelLoadImg" : MessageLookupByLibrary.simpleMessage("Load a image"),
    "labelTakePhoto" : MessageLookupByLibrary.simpleMessage("Take a photo"),
    "libraryName" : MessageLookupByLibrary.simpleMessage("Library name"),
    "loadingData" : MessageLookupByLibrary.simpleMessage("Loading data"),
    "loginWithGoogle" : MessageLookupByLibrary.simpleMessage("Login with Google"),
    "logout" : MessageLookupByLibrary.simpleMessage("Log out"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "otherReviews" : MessageLookupByLibrary.simpleMessage("Other reviews"),
    "pages" : MessageLookupByLibrary.simpleMessage("Pages"),
    "price" : MessageLookupByLibrary.simpleMessage("Price"),
    "priceError" : MessageLookupByLibrary.simpleMessage("Pages must be a number"),
    "publish" : MessageLookupByLibrary.simpleMessage("Publish"),
    "publisher" : MessageLookupByLibrary.simpleMessage("Publisher"),
    "releaseDate" : MessageLookupByLibrary.simpleMessage("Release date"),
    "review" : MessageLookupByLibrary.simpleMessage("Your review"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "savingInformations" : MessageLookupByLibrary.simpleMessage("Saving the informations"),
    "savingLibrary" : MessageLookupByLibrary.simpleMessage("Saving library"),
    "selectLibrary" : MessageLookupByLibrary.simpleMessage("Select Library"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "showLess" : MessageLookupByLibrary.simpleMessage("Show less"),
    "showMore" : MessageLookupByLibrary.simpleMessage("Show more"),
    "sortAZ" : MessageLookupByLibrary.simpleMessage("Title A-Z"),
    "sortNewest" : MessageLookupByLibrary.simpleMessage("Newest First"),
    "sortOldest" : MessageLookupByLibrary.simpleMessage("Oldest First"),
    "sortZA" : MessageLookupByLibrary.simpleMessage("Title Z-A"),
    "sortingOptions" : MessageLookupByLibrary.simpleMessage("Sorting options"),
    "suggestChanges" : MessageLookupByLibrary.simpleMessage("Suggest changes"),
    "surname" : MessageLookupByLibrary.simpleMessage("Surname"),
    "title" : MessageLookupByLibrary.simpleMessage("Title"),
    "view" : MessageLookupByLibrary.simpleMessage("View"),
    "wait" : MessageLookupByLibrary.simpleMessage("Please wait...")
  };
}
