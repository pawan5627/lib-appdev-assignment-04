import 'package:flutter/material.dart';
import 'package:lib_appdev_assignment04/models/books_model.dart';
import 'package:lib_appdev_assignment04/reporsitory/book_repository.dart';

class BooksProvider with ChangeNotifier {
  List<Book> books = [];

  bool isBooksFetching = false;

  final BookRepo _bookRepo = FirebaseBooksRepository();
  // final BookRepo _bookRepo = MockBooksRepository();

  void fetchBooks() async {
    isBooksFetching = true;
    await Future.delayed(
      const Duration(seconds: 1),
    );
    notifyListeners();
    print("beining");
    books = await _bookRepo.fetchBookList();
    isBooksFetching = false;
    notifyListeners();
  }

  void addBook(Book book) async {
    await _bookRepo.addBook(book);
    fetchBooks();
  }

  void updateBook(Book book) async {
    await _bookRepo.updateBook(book);
    fetchBooks();
  }

  void deleteBook(Book book) async {
    await _bookRepo.deleteBook(book);
    fetchBooks();
  }

  void markFavorite(Book book) async {
    await _bookRepo.markFavorite(book);
    fetchBooks();
  }

}