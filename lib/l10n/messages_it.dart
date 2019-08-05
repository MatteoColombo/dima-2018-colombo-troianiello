// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  get localeName => 'it';

  static m0(n) => "${Intl.plural(n, zero: 'Questa libreria è vuota', one: 'Contiene un libro', other: 'Contiene ${n} libri')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addNewBook" : MessageLookupByLibrary.simpleMessage("Aggiungi un nuovo libro"),
    "allReviews" : MessageLookupByLibrary.simpleMessage("Tutte"),
    "areYouSure" : MessageLookupByLibrary.simpleMessage("Sei sicuro di voler procedere?"),
    "authorErrorMessage" : MessageLookupByLibrary.simpleMessage("L\'autore deve avere un nome e un cognome"),
    "authors" : MessageLookupByLibrary.simpleMessage("Autori"),
    "bookAddedConfirm" : MessageLookupByLibrary.simpleMessage("Libro aggiunto alla libreria!"),
    "bookAlreadyPresent" : MessageLookupByLibrary.simpleMessage("Il libro è già presente nella libreria!"),
    "bookCount" : m0,
    "bookMoved" : MessageLookupByLibrary.simpleMessage("Libro spostato!"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Annulla"),
    "changeLibrary" : MessageLookupByLibrary.simpleMessage("Cambia libreria"),
    "close" : MessageLookupByLibrary.simpleMessage("Chiudi"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Sì"),
    "deleteBook" : MessageLookupByLibrary.simpleMessage("Cancella libro"),
    "deleteBookQuestion" : MessageLookupByLibrary.simpleMessage("Vuoi cancellare il libro?"),
    "deleteBooksQuestion" : MessageLookupByLibrary.simpleMessage("Vuoi cancellare i libri?"),
    "deleteLibrary" : MessageLookupByLibrary.simpleMessage("Cancella libreria"),
    "deleteSelectedLibsConfirm" : MessageLookupByLibrary.simpleMessage("Cancellare librerie selezionate?"),
    "description" : MessageLookupByLibrary.simpleMessage("Descrizione"),
    "done" : MessageLookupByLibrary.simpleMessage("Fatto"),
    "editLibrary" : MessageLookupByLibrary.simpleMessage("Modifica libreria"),
    "edition" : MessageLookupByLibrary.simpleMessage("Edizione"),
    "error" : MessageLookupByLibrary.simpleMessage("Errore"),
    "favouriteLibrary" : MessageLookupByLibrary.simpleMessage("Libreria preferita"),
    "fieldError" : MessageLookupByLibrary.simpleMessage("Questo campo non può essere vuoto"),
    "hintReview" : MessageLookupByLibrary.simpleMessage("Scrivi una recensione (opzionale)"),
    "insertImage" : MessageLookupByLibrary.simpleMessage("Inserisci un\'immagine"),
    "invalidISBN" : MessageLookupByLibrary.simpleMessage("Un ISBN valido è composto da 13 cifre!"),
    "isbn" : MessageLookupByLibrary.simpleMessage("ISBN"),
    "labelLoadImg" : MessageLookupByLibrary.simpleMessage("Carica immagine"),
    "labelTakePhoto" : MessageLookupByLibrary.simpleMessage("Scatta una foto"),
    "libraryName" : MessageLookupByLibrary.simpleMessage("Nome libreria"),
    "loadingData" : MessageLookupByLibrary.simpleMessage("Caricamento dati"),
    "loginWithGoogle" : MessageLookupByLibrary.simpleMessage("Accedi con Google"),
    "logout" : MessageLookupByLibrary.simpleMessage("Esci"),
    "name" : MessageLookupByLibrary.simpleMessage("Nome"),
    "otherReviews" : MessageLookupByLibrary.simpleMessage("Altre recensioni"),
    "pages" : MessageLookupByLibrary.simpleMessage("Pagine"),
    "price" : MessageLookupByLibrary.simpleMessage("Prezzo"),
    "priceError" : MessageLookupByLibrary.simpleMessage("Deve essere un numero"),
    "publish" : MessageLookupByLibrary.simpleMessage("Pubblica"),
    "publisher" : MessageLookupByLibrary.simpleMessage("Editore"),
    "releaseDate" : MessageLookupByLibrary.simpleMessage("Data di pubblicazione"),
    "review" : MessageLookupByLibrary.simpleMessage("La tua recensione"),
    "save" : MessageLookupByLibrary.simpleMessage("Salva"),
    "savingInformations" : MessageLookupByLibrary.simpleMessage("Salvataggio delle informazioni"),
    "savingLibrary" : MessageLookupByLibrary.simpleMessage("Salvataggio libreria"),
    "selectLibrary" : MessageLookupByLibrary.simpleMessage("Seleziona libreria"),
    "settings" : MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "showLess" : MessageLookupByLibrary.simpleMessage("Mostra meno"),
    "showMore" : MessageLookupByLibrary.simpleMessage("Mostra di più"),
    "sortAZ" : MessageLookupByLibrary.simpleMessage("Titolo A-Z"),
    "sortNewest" : MessageLookupByLibrary.simpleMessage("Più nuovi prima"),
    "sortOldest" : MessageLookupByLibrary.simpleMessage("Più vecchi prima"),
    "sortZA" : MessageLookupByLibrary.simpleMessage("Titolo Z-A"),
    "sortingOptions" : MessageLookupByLibrary.simpleMessage("Ordina per"),
    "suggestChanges" : MessageLookupByLibrary.simpleMessage("Suggerisci correzioni"),
    "surname" : MessageLookupByLibrary.simpleMessage("Cognome"),
    "title" : MessageLookupByLibrary.simpleMessage("Titolo"),
    "view" : MessageLookupByLibrary.simpleMessage("Visualizza"),
    "wait" : MessageLookupByLibrary.simpleMessage("Attendere...")
  };
}
