import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/widgets/custom_app_bar.dart';
import 'package:to_do/widgets/custom_note_cart.dart';
import 'package:to_do/widgets/noteL_list_view.dart';

class NotesViewBody extends StatelessWidget {
  const NotesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CustomAppBar(title:'Notes' ,icon: Icons.search,),
          Expanded(child: NotelListView())
        ],
      ),
    );
  }
}

