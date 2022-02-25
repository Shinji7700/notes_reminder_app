import 'package:notes_reminder_app/core/db/model/note_event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventsDataSource extends CalendarDataSource {
  EventsDataSource(List<NoteEventModel> events) {
    appointments = events;
  }

  NoteEventModel getEvent(int index) => appointments![index] as NoteEventModel;

  @override
  DateTime getStartTime(int index) => getEvent(index).eventDate;

  @override
  String getSubject(int index) => getEvent(index).noteTitle;

  @override
  String? getNotes(int index) => getEvent(index).noteDesc;
}
