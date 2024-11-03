import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/models/note_model.dart';

part 'fetch_notes.g.dart';

final NotesProvider =
    NotifierProvider<FetchNotes, List<NoteModel>>(FetchNotes.new);

@Riverpod(keepAlive: true)
class FetchNotes extends _$FetchNotes {
  dynamic d;
  @override
  List<NoteModel> build() {
    return [];
  }

  getAllNotes() {
    // d = Hive.box(kNotesBox).values.toList();
    // return d;
    try {
      // print('ddddddddddd');
      // print(Hive.box(kNotesBox).values.toList());
      print('vvvvvvvvvv');
      d = Hive.box(kNotesBox).values.toList();
      print(d);
      return d;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
