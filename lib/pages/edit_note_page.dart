import 'package:flutter/material.dart';
import 'package:to_do/models/note_model.dart';
import 'package:to_do/widgets/edit_note_page_body.dart';

class EditNotePage extends StatelessWidget {
  const EditNotePage({super.key, required this.note});
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: EditNewPageBody(note: note,),
    );
  }
}
