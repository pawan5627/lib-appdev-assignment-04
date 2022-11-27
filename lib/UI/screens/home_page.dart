import 'package:flutter/material.dart';
import 'package:lib_appdev_assignment04/providers/book_provider.dart';
import 'package:lib_appdev_assignment04/UI/screens/add_books.dart';
import 'package:lib_appdev_assignment04/UI/screens/book_details.dart';
import 'package:lib_appdev_assignment04/UI/widgets/book_card.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<BooksProvider>().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    final booklist = context.watch<BooksProvider>().books;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF800000),
      ),
      body: context.watch<BooksProvider>().isBooksFetching
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: booklist.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: bookCard(book: booklist[index],),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BookDetails(book: booklist[index])));
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddBook()));
        },
        backgroundColor: Color(0xFF800000),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}