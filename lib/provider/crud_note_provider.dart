import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/models/note_model.dart';

part 'add_note_provider.g.dart';

@riverpod
class AddNoteNotifier extends _$AddNoteNotifier {
  Color? plateColor;
  @override
  FutureOr<NoteModel> build() {
    return NoteModel(title: '', content: '', color: 1, date: '');
  }

  Future<void> addNote(
      {required String title,
      required String content,
      required String date}) async {
    NoteModel note = NoteModel(
        title: title, content: content, date: date, color: plateColor!.value);
    state = const AsyncLoading();
    print('dddddd');
    await Future.delayed(Duration(seconds: 2), () async {
      try {
        var noteBox = Hive.box(kNotesBox);

        await noteBox.add(note);
        //    print(Hive.box(kNotesBox).values.toList());
        state = AsyncData(note);
      } on Exception catch (e) {
        state = AsyncError(e.toString(), StackTrace.current);
      }
    });
  }

  void deleteNote(NoteModel note) {
    var noteBox = Hive.box(kNotesBox);
    try {
      noteBox.delete(note.key);
      state = AsyncData(note);
    } on Exception catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  void editNote(notekey, NoteModel note) async {
    var noteBox = Hive.box(kNotesBox);
    await noteBox.put(notekey, note);
    state = AsyncData(note);
  }

  void setColor({required Color c}) {
    plateColor = c;
  }
}
