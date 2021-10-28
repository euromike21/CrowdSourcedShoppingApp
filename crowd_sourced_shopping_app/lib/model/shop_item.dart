final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, title, time
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String time = 'time';
}

class Note {
  final int? id;
  final String title;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.title,
    required this.createdTime,
  });

  Note copy({
    int? id,
    String? title,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
