import 'package:flutter/material.dart';
import 'package:lib_appdev_assignment04/UI/widgets/fav_icon.dart';
import 'package:provider/provider.dart';

import '../../models/books_model.dart';
import '../../providers/book_provider.dart';

class bookCard extends StatefulWidget {
  Book book;

  bookCard({super.key, required this.book});

  @override
  State<bookCard> createState() => _bookCardState();
}

class _bookCardState extends State<bookCard> {
  var concatenate = StringBuffer();
  bool fav = false;

  @override
  void initState() {
    super.initState();
    fav = widget.book.isfavorite;
    // TODO: implement initState
    for (var item in widget.book.authors) {
      concatenate.write(
          widget.book.authors.indexOf(item) != (widget.book.authors.length - 1)
              ? '$item, '
              : item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 132,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(66, 56, 56, 56).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                          image: NetworkImage(widget.book.bookImageURL),
                          fit: BoxFit.fill),
                      color: Color(0xffD3D3D3)),
                ),
                const SizedBox(
                  width: 32,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.bookName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          concatenate.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            isfavIcon(
                onTap: () {
                  widget.book.isfavorite = !widget.book.isfavorite;
                  context.read<BooksProvider>().markFavorite(widget.book);
                },
                color: fav)
          ],
        ),
      ),
    );
  }
}