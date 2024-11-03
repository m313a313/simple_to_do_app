import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/models/note_model.dart';

class CustomButton extends ConsumerStatefulWidget {
  const CustomButton(
      {required this.addnoteState, required this.onTap, super.key});
  final void Function()? onTap;
  final AsyncValue<NoteModel> addnoteState;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends ConsumerState<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: MediaQuery.sizeOf(context).width,
        height: 45,
        child: widget.addnoteState.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : const Center(
                child: Text('Add',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
      ),
    );
  }
}
