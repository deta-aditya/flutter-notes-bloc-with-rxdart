import 'dart:async';
import 'dart:math';

import 'package:flutter_notes/types/note.dart';

class LocalNoteDataProvider {
  List<Note> _notes = [
    Note(
      id: 0,
      title: 'Map',
      content: 'This is the map that leads to an endless adventure. Lorem ipsum dolor sit amet.',
      createdAt: DateTime.now(),
      tags: ['map'],
    ),
    Note(
      id: 1,
      title: 'Secret Tasks',
      content: 'These are the tasks you need to do in order to infiltrate the secret facility.',
      createdAt: DateTime.now(),
      tags: ['task', 'secret'],
    ),
    Note(
      id: 2,
      title: 'Grocery',
      content: '1. Bread whole wheat 2. Jelly jam 3. Diet cereal.',
      createdAt: DateTime.now(),
      tags: [],
    ),
  ];

  Future<List<Note>> fetch() {
    return Future(() => _notes);
  }

  Future<void> update(Note newNote) {
    _notes = _notes
      .where((Note note) => note.id != newNote.id)
      .toList()
      ..add(newNote);

    return Future(() => {});
  }

  Future<void> insert(Note note) {
    _notes.add(note.copyWith(
      id: Random().nextInt(100)
    ));

    return Future(() => {});
  }

  Future<void> delete(Note newNote) {
    _notes = _notes
      .where((Note note) => note.id != newNote.id)
      .toList();

    return Future(() => {});
  }
}