import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/books_model.dart';
import '../../providers/book_provider.dart';
import '../widgets/text_field.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _formKey = GlobalKey<FormState>();
  var name = '';
  var publisherName = '';
  var authors = '';
  var imageURl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
        backgroundColor: Color(0xFF800000),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  label: 'Book Name',
                  text: (text) {
                    name = text;
                  },
                ),
                CustomTextField(
                  label: 'Authors',
                  hint: 'Add authors separated by comma (,)',
                  text: (text) {
                    authors = text;
                  },
                ),
                CustomTextField(
                  label: 'Publisher Name',
                  text: (text) {
                    publisherName = text;
                  },
                ),
                CustomTextField(
                  label: 'Image URL',
                  text: (text) {
                    imageURl = text;
                  },
                ),
              Padding(padding: EdgeInsets.all(16)),
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
                        );
                        context.read<BooksProvider>().addBook(book);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFD3D3D3),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    minimumSize: const Size(350, 50),
                    maximumSize: const Size(350, 50),

                  ),

                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}