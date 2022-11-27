import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/books_model.dart';
import 'package:lib_appdev_assignment04/providers/book_provider.dart';
import '../widgets/text_field.dart';

class BookDetails extends StatefulWidget {
  Book book;

  BookDetails({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final _formKey = GlobalKey<FormState>();
  var name = '';
  var publisherName = '';
  var authors = '';
  var imageURl = '';
  var concatenate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var item in widget.book.authors) {
      concatenate +=
          widget.book.authors.indexOf(item) != (widget.book.authors.length - 1)
              ? '$item, '
              : item;
    }

    name = widget.book.bookName;
    publisherName = widget.book.publisherName;
    authors = concatenate;
    imageURl = widget.book.bookImageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        backgroundColor: Color(0xFF800000),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('ISBN: ${widget.book.isbnNumber}'),
                CustomTextField(
                  label: 'Book Name',
                  text: (text) {
                    name = text;
                  },
                  content: name,
                ),
                CustomTextField(
                  label: 'Authors',
                  hint: 'Add authors separated by comma (,)',
                  text: (text) {
                    authors = text;
                  },
                  content: authors,
                ),
                CustomTextField(
                  label: 'Publisher Name',
                  text: (text) {
                    publisherName = text;
                  },
                  content: publisherName,
                ),
                CustomTextField(
                  label: 'Image URL',
                  text: (text) {
                    imageURl = text;
                  },
                  content: imageURl,
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Book book = Book(
                              bookName: name,
                              authors: authors.replaceAll(' ', '').split(','),
                              publisherName: publisherName,
                              bookImageURL:
                              imageURl,
                              isfavorite: false,
                              isbnNumber: widget.book.isbnNumber
                            );
                            context.read<BooksProvider>().updateBook(book);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD3D3D3),
                        maximumSize: const Size(150, 40),
                        minimumSize:  const Size(150, 40)
                    ),
                      ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BooksProvider>().deleteBook(widget.book);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF800000),
                      maximumSize: const Size(150, 40),
                      minimumSize:  const Size(150, 40)
                    ),
                    child: const Text('Delete'),
                  ),
                ],
              ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}