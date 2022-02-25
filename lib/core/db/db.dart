import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_reminder_app/core/db/model/note_event_model.dart';

// ignore: avoid_classes_with_only_static_members
/// main database class for hive
class DB {
  /// initialise database
  Future<void> init() async {
    // initialised models here
    Hive.registerAdapter(NoteEventModelAdapter());

    // initialise database
    await Hive.initFlutter();

    // open hive box
    await Hive.openBox<NoteEventModel>('NotesReminder');
  }

  ///To get the note reminder box
  Box<NoteEventModel> getNoteEvent() =>
      Hive.box<NoteEventModel>('NotesReminder');
}

/// for getting access to [DB] class
final db = DB();
