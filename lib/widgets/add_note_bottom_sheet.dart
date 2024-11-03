import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/models/note_model.dart';
import 'package:to_do/provider/crud_note_provider.dart';
import 'package:to_do/widgets/custom_button.dart';
import 'package:to_do/widgets/custom_text_field.dart';

class AddNoteBottomSheetBody extends ConsumerStatefulWidget {
  const AddNoteBottomSheetBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNoteBottomSheetBodyState();
}

class _AddNoteBottomSheetBodyState
    extends ConsumerState<AddNoteBottomSheetBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? title, content;
  @override
  Widget build(BuildContext context) {
    final addnoteState = ref.watch(addNoteNotifierProvider);
    return AbsorbPointer(
      absorbing: addnoteState.isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  hint: 'Title',
                  onSaved: (value) => title = value,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hint: 'Content',
                  maxLines: 5,
                  onSaved: (value) => content = value,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  addnoteState: addnoteState,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      var currentdate = DateTime.now();
                      var formattedDate = DateFormat.yMEd().format(currentdate);
                      formKey.currentState!.save();
                      await ref.read(addNoteNotifierProvider.notifier).addNote(
                          NoteModel(
                              title: title!,
                              content: content!,
                              date: formattedDate,
                              color: Colors.pink.value));
                      Navigator.pop(context);
                    } else {
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
