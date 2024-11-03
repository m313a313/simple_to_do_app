import 'package:flutter/material.dart';
import 'package:to_do/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.maxLines = 1, this.onSaved,
  });
  final String hint;
  final int maxLines;
final  void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator:(value){
        if(value?.isEmpty ?? true){
          return 'Field cannot be empty';
        }
      } ,
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      decoration: InputDecoration(
          hintText: hint,
          //  hintStyle: TextStyle( ena color: kPrimaryColor),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(8))),
    );

  }
}
