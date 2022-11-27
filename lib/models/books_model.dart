class Book {
  String bookName;
  List<String> authors;
  String publisherName;
  String? isbnNumber;
  String bookImageURL;
  bool isfavorite;

  Book(
      {required this.bookName,
      required this.authors,
      required this.publisherName,
      required this.bookImageURL,
         this.isbnNumber,
      required this.isfavorite});

  static Book fromJson(Map<String, dynamic> json, String id) => Book(
        bookName: json['first'] as String? ?? '',
        authors: (json['authors'] as List?)?.map((item) => item as String).toList() ?? [],
        publisherName: json['publisherName'] as String? ?? '',
        bookImageURL: json['bookImageURL'] as String? ?? '',
        isbnNumber: id,
        isfavorite: json['isFav'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
    'first': bookName,
    'authors': authors,
    'publisherName': publisherName,
    'bookImageURL': bookImageURL,
    'isFav': isfavorite,
  };

  @override
  String toString() {
    // TODO: implement toString
    return bookName;
  }
}