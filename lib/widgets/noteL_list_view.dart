import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/provider/crud_note_provider.dart';
import 'package:to_do/provider/fetch_notes.dart';
import 'package:to_do/widgets/custom_note_cart.dart';

class NotelListView extends ConsumerStatefulWidget {
  const NotelListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotelListViewState();
}

class _NotelListViewState extends ConsumerState<NotelListView> {
  @override
  Widget build(BuildContext context) {
    final ff = ref.watch(addNoteNotifierProvider);
    final notes = ref.read(NotesProvider.notifier).getAllNotes();
    //  final d = Hive.box(kNotesBox).values.toList() ;

    //  print(d);

    ff.when(data: (d) {
      print(d.title);
    }, error: (e, s) {
      print(e.toString());
    }, loading: () {
      print("zzz");
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: notes.length,
          itemBuilder: (context, x) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomNoteCart(note: notes[x]),
            );
          }),
    );
  }
}
