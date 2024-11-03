import 'package:flutter/material.dart';
import 'package:to_do/widgets/edit_note_page_body.dart';

class EditNotePage extends StatelessWidget {
  const EditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: EditNewPageBody(),);
  }
}