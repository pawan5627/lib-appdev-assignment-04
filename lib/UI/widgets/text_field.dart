import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final Function(String) text;
  final String? hint;
  final String? content;

  const CustomTextField({Key? key, required this.label, required this.text, this.hint, this.content})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        readOnly: false,
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.black),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 1, color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 2, color: Colors.blue)),
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          hintText: widget.hint ?? '',
        ),
        cursorColor: Colors.black,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '*Required';
          }
          return null;
        },
        onChanged: (text){
          widget.text(text);
        },
      ),
    );
  }
}