import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/models/note_model.dart';

part 'add_note_provider.g.dart';

@riverpod
class AddNoteNotifier extends _$AddNoteNotifier {
  @override
  FutureOr<NoteModel> build() {
    return NoteModel(title: '', content: '', color: 1, date: '');
  }

  Future<void> addNote(NoteModel note) async {
    state = const AsyncLoading();
    print('dddddd');
    await Future.delayed(Duration(seconds: 2), () async {
      var noteBox = Hive.box(kNotesBox);
      try {
        await noteBox.add(note);
    //    print(Hive.box(kNotesBox).values.toList());
        state = AsyncData(note);
      } on Exception catch (e) {
        state = AsyncError(e.toString(), StackTrace.current);
      }
    });
  }
  void deleteNote(NoteModel note)  {
      var noteBox = Hive.box(kNotesBox);
      try {
        noteBox.delete(note.key);
        state = AsyncData(note);
      } on Exception catch (e) {
        state = AsyncError(e.toString(), StackTrace.current);
      }
    
  }
}
