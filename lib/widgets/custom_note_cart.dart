import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/models/note_model.dart';
import 'package:to_do/pages/edit_note_page.dart';
import 'package:to_do/provider/crud_note_provider.dart';

class CustomNoteCart extends StatelessWidget {
  const CustomNoteCart({
    super.key,
    required this.note,
  });
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const EditNotePage();
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 24, top: 24, bottom: 24, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.yellow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(fontSize: 26, color: Colors.black),
                ),
                Transform.translate(
                  offset: const Offset(0, 14),
                  child: Consumer(
                    builder: (context, ref, child) => IconButton(
                        onPressed: () {
                          ref
                              .read(addNoteNotifierProvider.notifier)
                              .deleteNote(note);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 28,
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(note.content,
                  style: TextStyle(
                      fontSize: 20, color: Colors.black.withOpacity(.4))),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(note.date,
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.4))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
