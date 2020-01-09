import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_notes/blocs/notes_bloc.dart';
import 'package:flutter_notes/screens/add_screen.dart';
import 'package:flutter_notes/screens/edit_screen.dart';
import 'package:flutter_notes/types/note.dart';
import 'package:flutter_notes/widgets/note_list_item.dart';

class MainScreen extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllNotes();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flapnote'),
      ),
      body: StreamBuilder(
        stream: bloc.allNotes,
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            final notes = snapshot.data;

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                return NoteListItem(
                  note: notes[index],
                  onTapped: _handleOnNoteItemTapped(context),
                  onDelete: _handleOnNoteItemDelete(context),
                );
              },
            );

          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ), 
      floatingActionButton: FloatingActionButton(
        onPressed: _handleOnFabPressed(context),
        tooltip: 'Add new note',
        child: Icon(Icons.add),
      ),
    );
  }

  Function() _handleOnFabPressed(BuildContext context) => () {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => AddScreen()
    ));
  };

  OnNoteItemTapped _handleOnNoteItemTapped(BuildContext context) => 
    (Note note) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => EditScreen(
          note: note,
        )
      ));
    };

  OnNoteItemDelete _handleOnNoteItemDelete(BuildContext context) => 
    (Note note) {
      showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Note?'),
            content: Text('Are you sure you want to delete this note?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Delete'.toUpperCase()), 
                onPressed: () => Navigator.of(context).pop(true),
              ),
              FlatButton(
                child: Text('Cancel'.toUpperCase()), 
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          );
        }
      ).then<bool>(_handleDelete(note))
      .catchError((error) => print(error));
    };

  Future<bool> Function(bool) _handleDelete(Note note) => 
    (bool shouldDelete) async {
      if (shouldDelete) {
        await bloc.deleteNote(note);
      }

      return false;
    };
}
