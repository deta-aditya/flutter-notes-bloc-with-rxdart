import 'dart:convert';

class Note {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final List<String> tags;
  Note({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.tags,
  });

  Note copyWith({
    int id,
    String title,
    String content,
    DateTime createdAt,
    List<String> tags,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'tags': List<dynamic>.from(tags.map((x) => x)),
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  static Note fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note id: $id, title: $title, content: $content, createdAt: $createdAt, tags: $tags';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Note &&
      o.id == id &&
      o.title == title &&
      o.content == content &&
      o.createdAt == createdAt &&
      o.tags == tags;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      createdAt.hashCode ^
      tags.hashCode;
  }
}