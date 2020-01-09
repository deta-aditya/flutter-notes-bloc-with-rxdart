import 'package:flutter_notes/resources/repository.dart';
import 'package:flutter_notes/types/note.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  final _repository = Repository();

  final _notesFetcher = PublishSubject<List<Note>>();
  Observable<List<Note>> get allNotes => _notesFetcher.stream;

  Future<void> fetchAllNotes() async {
    _notesFetcher.sink.add(await _repository.fetchAllNotes());
  }

  Future<void> insertNote(Note note) async {
    await _repository.insertNote(note);
    fetchAllNotes();
  }

  Future<void> updateNote(Note note) async {
    await _repository.updateNote(note);
    fetchAllNotes();
  }

  Future<void> deleteNote(Note note) async {
    await _repository.deleteNote(note);
    fetchAllNotes();
  }

  dispose() {
    _notesFetcher.close();
  }

}

final bloc = NotesBloc();