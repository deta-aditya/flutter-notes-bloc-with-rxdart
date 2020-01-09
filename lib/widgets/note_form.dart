import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_notes/types/note.dart';

typedef OnNoteSave = Future<void> Function(Note);

class NoteForm extends StatefulWidget {
  final Note note;
  final OnNoteSave onSave;
  NoteForm({
    Key key,
    @required this.note,
    @required this.onSave
  });
  
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  TextEditingController _titleController;
  TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            autofocus: false,
            controller: _titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.note.title,
            ),
            style: Theme.of(context).textTheme.title.copyWith(
              color: Colors.white
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: TextField(
            autofocus: false,
            controller: _contentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          )
        ),
      ), 
      onWillPop: _handleOnWillPop(context)
    );
  }

  Future<bool> Function() _handleOnWillPop(BuildContext context) => 
    () {
      return _checkIfChangeExists()
        .then<bool>(_showDialogIfNoChanges)
        .catchError((error) {
          print(error);
        });
    };

  Future<bool> _checkIfChangeExists() {
    return Future(() => 
      widget.note.title == _titleController.text &&
      widget.note.content == _contentController.text
    );
  }

  FutureOr<bool> _showDialogIfNoChanges(hasChanges) {
    if (hasChanges) {
      return true;
    }
    return showDialog<bool>(
      context: context,
      builder: _buildSaveOrDiscardDialog,
    );
  }

  Widget _buildSaveOrDiscardDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Save Changes?'),
      content: Text('If you choose discard, changes will not be saved.'),
      actions: <Widget>[
        FlatButton(
          child: Text('Save'.toUpperCase()), 
          onPressed: _handleOnSave(context),
        ),
        FlatButton(
          child: Text('Discard'.toUpperCase()), 
          onPressed: () => Navigator.of(context).pop(true),
        ),
        FlatButton(
          child: Text('Cancel'.toUpperCase()), 
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }

  Future<void> Function() _handleOnSave(BuildContext context) => () async {
    await widget.onSave(widget.note.copyWith(
      title: _titleController.text,
      content: _contentController.text,
    ));

    Navigator.of(context).pop(true);
  };

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}