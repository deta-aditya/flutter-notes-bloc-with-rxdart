import 'package:flutter/material.dart';
import 'package:flutter_notes/types/note.dart';

typedef OnNoteItemTapped = void Function(Note);
typedef OnNoteItemDelete = void Function(Note);

enum PopupAction {
  hide,
  erase,
  properties,
}

Map<PopupAction, String> popupActionText = {
  PopupAction.hide: 'Hide',
  PopupAction.erase: 'Erase',
  PopupAction.properties: 'Properties',
};

class NoteListItem extends StatelessWidget {
  final Note note;
  final OnNoteItemTapped onTapped;
  final OnNoteItemDelete onDelete;

  NoteListItem({
    Key key,
    @required this.note,
    this.onTapped,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const contentPadding = EdgeInsets.only(
      left: 20, 
      top: 15, 
      bottom: 15, 
      right: 10
    );

    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(note.title),
      ),
      subtitle: Text(note.content),
      contentPadding: contentPadding,
      trailing: PopupMenuButton<PopupAction>(
        onSelected: onPopupButtonSelected(context),
        itemBuilder: buildPopupMenu
      ),
      onTap: handleOnListTileTapped,
    );
  }

  List<PopupMenuEntry<PopupAction>> buildPopupMenu(BuildContext context) => 
    PopupAction.values.map((PopupAction popup) =>
      PopupMenuItem<PopupAction>(
        value: popup,
        child: Text(popupActionText[popup]),
      )).toList();

  void Function(PopupAction) onPopupButtonSelected(BuildContext context) =>
    (PopupAction selected) {
      switch (selected) {
        case PopupAction.erase:
          onDelete?.call(note);
          break;
        case PopupAction.hide: 
          break;
        case PopupAction.properties: 
          break;
      }
    };

  void handleOnListTileTapped() {
    onTapped?.call(note);
  }
}
