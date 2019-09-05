# dima2018_colombo_troianiello

## Members of the team
* Colombo Matteo     - 883114 - 10459278
* Troianiello Andrea - 898113 - 10455250

## Description of the application

NonSoloLibri is a small social network application designed for book enthusiast that allows them to organize and review their collection.<br/>
Users will be able to create libraries and to organize books in them.<br/>
Beside the storing functionality, NonSoloLibri has a social part that allows them to connect with other people with a friendship system.<br/>
Friends will be able to see the each other collections and wish-lists, so that they can surprise each other with presents.<br/>
A market place is available, where every verified user will be able to sell or buy books.

## Main folders
* **lib:** This folder contains the source code of the application.
* **dd:** All LaTeX source code concerning the design document, that is a technical description of this application.
* **delivery:** Contains the design document pdf, the elevator pitch and the presentetion.


## Testing
flutter test

coverage:
flutter test --coverage

to visualize you need lcov, then:

genhtml coverage/lcov.info -o coverage/html
