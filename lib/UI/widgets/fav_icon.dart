import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class isfavIcon extends StatelessWidget {
  const isfavIcon({super.key, required this.onTap, required this.color});
  final VoidCallback onTap;
  final bool color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.favorite,
          color: color ? Colors.red : Colors.grey,
          size: 32,
        ),
      ),
    );
  }
}