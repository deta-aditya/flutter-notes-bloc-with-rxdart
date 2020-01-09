import 'package:flutter_notes/resources/local_note_data_provider.dart';
import 'package:flutter_notes/types/note.dart';

class Repository {
  final _noteDataProvider = LocalNoteDataProvider();

  Future<List<Note>> fetchAllNotes() => _noteDataProvider.fetch();
  Future<void> updateNote(Note note) => _noteDataProvider.update(note);
  Future<void> insertNote(Note note) => _noteDataProvider.insert(note);
  Future<void> deleteNote(Note note) => _noteDataProvider.delete(note);
}