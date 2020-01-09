import 'package:flutter/material.dart';
import 'package:flutter_notes/blocs/notes_bloc.dart';
import 'package:flutter_notes/types/note.dart';
import 'package:flutter_notes/widgets/note_form.dart';

class AddScreen extends StatelessWidget {
  static const route = '/add';

  @override
  Widget build(BuildContext context) {
    return NoteForm(
      note: Note(),
      onSave: _handleOnSave,
    );
  }

  Future<void> _handleOnSave(Note note) async {
    await bloc.insertNote(note);
  }
}