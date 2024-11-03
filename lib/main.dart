import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/models/note_model.dart';
import 'package:to_do/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());

  await Hive.openBox(kNotesBox);

  runApp(const ProviderScope(child: ToDoApp()));
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
