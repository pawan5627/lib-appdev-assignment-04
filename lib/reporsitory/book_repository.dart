import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lib_appdev_assignment04/models/books_model.dart';

abstract class BookRepo {
  Future<List<Book>> fetchBookList();
  Future<void> addBook(Book book);
  Future<void> updateBook(Book book);
  Future<void> deleteBook(Book book);
  Future<void> markFavorite(Book book);
}

class FirebaseBooksRepository implements BookRepo {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<Book>> fetchBookList() async {
    List<Book> books = [];
    print("started");
    await db.collection("book").get().then((event) {
      books = event.docs.map((e) => Book.fromJson(e.data(), e.id)).toList();
    });
    print("working");
    return books;
  }

  @override
  Future<void> addBook(Book book) async {
    db.collection('book').add(book.toJson()).then((value) {
      print("Book added.");
    }).catchError((error) => print("Failed to add Task: $error"));
  }

  @override
  Future<void> updateBook(Book book) async {
    await db.collection('book').doc(book.isbnNumber).update({
      'first': book.bookName,
      'authors': book.authors,
      'publisherName': book.publisherName,
      'bookImageURL': book.bookImageURL,
    }).then((value) {
      print("Book updated");
    }).catchError((error) => print("Failed to updated Task: $error"));
  }

  @override
  Future<void> deleteBook(Book book) async {
    await db.collection('book').doc(book.isbnNumber).delete().then((value) {
      print("Book deleted.");
    }).catchError((error) => print("Failed to delete Task: $error"));

  }

  @override
  Future<void> markFavorite(Book book) async {
    await db.collection('book').doc(book.isbnNumber).update({
      'isFav': book.isfavorite,
    }).then((value) {
      print("Book updated");
    }).catchError((error) => print("Failed to updated Task: $error"));
  }
}

class MockBooksRepository implements BookRepo {
  final db = FirebaseFirestore.instance;
  List<Book> books = [
    Book(
      bookName: 'Book Name 5',
      authors: ['author1', 'author2'],
      publisherName: 'Publisher Name',
      bookImageURL:
      'https://miro.medium.com/focal/70/70/50/50/1*L6gfDRU9iPXpWx978BzcOw.png',
      isbnNumber: '1234',
      isfavorite: false,
    ),
  ];

  @override
  Future<List<Book>> fetchBookList() async {
    return books;
  }

  @override
  Future<void> addBook(Book book) async {
    books.add(book);
    print('Book added');
  }

  @override
  Future<void> updateBook(Book book) async {
    books.forEach((b) {
      if(b.isbnNumber == book.isbnNumber){
        b.bookName = book.bookName;
        b.publisherName = book.publisherName;
        b.authors = book.authors;
        b.bookImageURL = book.bookImageURL;
      }
    });
    print('Book updated');
  }

  @override
  Future<void> deleteBook(Book book) async {
    books.remove(book);
    print('Book deleted');
  }

  @override
  Future<void> markFavorite(Book book) async {
    books.forEach((b) {
      if(b.isbnNumber == book.isbnNumber){
        b.isfavorite = book.isfavorite;
      }
    });
    print('Book updated');
  }

}