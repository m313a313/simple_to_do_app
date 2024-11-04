import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:to_do/constants.dart';
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
    ref.read(addNoteNotifierProvider.notifier).setColor(c: kColorsList[0]);
    final addnoteState = ref.watch(addNoteNotifierProvider);
    return AbsorbPointer(
      absorbing: addnoteState.isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                ColorItemListview(),
                CustomButton(
                  addnoteState: addnoteState,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      var currentdate = DateTime.now();
                      var formattedDate = DateFormat.yMEd().format(currentdate);
                      formKey.currentState!.save();

                      await ref.read(addNoteNotifierProvider.notifier).addNote(
                            title: title!,
                            content: content!,
                            date: formattedDate,
                          );
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

class ColorItem extends StatelessWidget {
  const ColorItem(
      {super.key, required this.isActive, required this.backgroundColor});
  final bool isActive;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: isActive ? 32 : 30,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}

class ColorItemListview extends ConsumerStatefulWidget {
  const ColorItemListview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ColorItemListviewState();
}

class _ColorItemListviewState extends ConsumerState<ColorItemListview> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kColorsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                currentIndex = index;
                ref
                    .read(addNoteNotifierProvider.notifier)
                    .setColor(c: kColorsList[index]);
                setState(() {});
              },
              child: ColorItem(
                  isActive: index == currentIndex,
                  backgroundColor: kColorsList[index]));
        },
      ),
    );
  }
}
