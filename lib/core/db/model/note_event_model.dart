import 'package:hive/hive.dart';

part 'note_event_model.g.dart';

/// for storing user address of the user
@HiveType(typeId: 0)
class NoteEventModel extends HiveObject {
  ///
  @HiveField(0)
  late String noteTitle;

  ///
  @HiveField(1)
  late String noteDesc;

  ///
  @HiveField(2)
  late DateTime eventDate;
}
