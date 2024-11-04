import 'package:flutter/material.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/widgets/add_note_bottom_sheet.dart';
import 'package:to_do/widgets/notes_view_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (context) {
                return AddNoteBottomSheetBody();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: const NotesViewBody(),
    );
  }
}

void _selectTime(
  BuildContext context,
) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime != null) {
    // ref.read(timeProvider.notifier).state = pickedTime;
  }
}
