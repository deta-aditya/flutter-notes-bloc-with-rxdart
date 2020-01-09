import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_notes/blocs/notes_bloc.dart';
import 'package:flutter_notes/types/note.dart';
import 'package:flutter_notes/widgets/note_form.dart';

class EditScreen extends StatelessWidget {
  static const route = '/edit';

  final Note note;
  EditScreen({
    Key key,
    @required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return NoteForm(
      note: note,
      onSave: _handleOnSave,
    );
  }

  Future<void> _handleOnSave (Note note) async {
    await bloc.updateNote(note);
  }
}