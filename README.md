App for managing my librarly, segregating books, finding where they are exactly (shelf and rack)

Based on simple stack from (Roda-Sequel-Stack)[https://github.com/jeremyevans/roda-sequel-stack].
Ruby 3.0.1
Elm for view

elm make src/Main.elm --output assets/js/MainElm.js
For now a simple elm integration. compile and then rackup

TODO:
1. Filtering - bibliotheca
2. Sorting - bibliotheca
3. Tabs for other stuff than bibliotheca
4. Deploy
5. Choosing rack or shelf, brings up the picture of it, with a list of books on it below - bibliotheca
6. Pagination - bibliotheca
