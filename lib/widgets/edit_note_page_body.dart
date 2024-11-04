import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/models/note_model.dart';
import 'package:to_do/provider/crud_note_provider.dart';
import 'package:to_do/provider/fetch_notes.dart';
import 'package:to_do/widgets/custom_app_bar.dart';
import 'package:to_do/widgets/custom_text_field.dart';

class EditNewPageBody extends StatefulWidget {
  const EditNewPageBody({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditNewPageBody> createState() => _EditNewPageBodyState();
}

class _EditNewPageBodyState extends State<EditNewPageBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? content, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Consumer(
              builder: (context, ref, child) => CustomAppBar(
                title: 'Edit Note',
                icon: Icons.check,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref.read(addNoteNotifierProvider.notifier).editNote(
                        widget.note.key,
                        NoteModel(
                            title: title!,
                            content: content!,
                            color: widget.note.color,
                            date: widget.note.date));
                        Navigator.pop(context);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
              onSaved: (value) => title = value!,
              hint: 'Title',
              initialValue: widget.note.title,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              onSaved: (value) => content = value!,
              hint: 'Content',
              initialValue: widget.note.content,
              maxLines: 5,
            )
          ],
        ),
      ),
    );
  }
}
