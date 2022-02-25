// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mobx/mobx.dart';
// import 'package:notes_reminder_app/core/db/db.dart';
// import 'package:notes_reminder_app/core/db/model/note_event_model.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// part 'calendar_event_store.g.dart';
//
// class CalendarEventStore = _CalendarEventStore with _$CalendarEventStore;
//
// abstract class _CalendarEventStore with Store {
//   ///To get the note name for the event
//   TextEditingController noteName = TextEditingController();
//
//   ///To get the note desc for the event
//   TextEditingController noteDesc = TextEditingController();
//
//   ///While adding we get the from date
//   @observable
//   DateTime? fromDate;
//
//   ///To load the data once the event is added to a list
//   @observable
//   bool isLoading = false;
//
//   ///We pick the from date while adding note event
//   Future pickFromDate(BuildContext context) async {
//     final currentDate = DateTime.now();
//     final newDate = await showDatePicker(
//       context: context,
//       initialDate: fromDate ?? currentDate,
//       firstDate: DateTime(DateTime.now().year - 5),
//       lastDate: DateTime(DateTime.now().year + 5),
//     );
//     if (newDate != null) {
//       fromDate = newDate;
//     }
//   }
//
//   ///To get the focused day
//   @observable
//   DateTime focusedDayMobx = DateTime.now();
//
//   ///To get the selected day in the calendar
//   @observable
//   DateTime selectedDayMobx = DateTime.now();
//
//   ///To show the kind of format that your calendar wants to show
//   @observable
//   CalendarFormat calendarFormat = CalendarFormat.month;
//
//   ///To get the day that has been selected
//   @action
//   void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(selectedDayMobx, selectedDay)) {
//       selectedDayMobx = selectedDay;
//       focusedDayMobx = focusedDay;
//     }
//   }
//
//   @action
//   void onFormatChanged(CalendarFormat format) {
//     if (calendarFormat != format) {
//       calendarFormat = format;
//     }
//   }
//
//   @action
//   bool isSameDayPredicate(DateTime day) {
//     return isSameDay(selectedDayMobx, day);
//   }
//
//   @action
//   void addEvent() {
//     isLoading = true;
//     final notes = NoteEventModel()
//       ..noteTitle = noteName.text
//       ..noteDesc = noteDesc.text
//       ..eventDate = fromDate!;
//     final noteBox = db.getNoteEvent();
//     noteBox.add(notes);
//     isLoading = false;
//   }
//
//   Future<bool?> showToast(String msg) {
//     return Fluttertoast.showToast(
//       msg: msg,
//       textColor: Colors.white,
//       webBgColor: 'linear-gradient(to right,#333333,#333333)',
//       webPosition: 'center',
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_reminder_app/core/db/db.dart';
import 'package:notes_reminder_app/core/db/model/note_event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'calendar_event_store.g.dart';

class CalendarEventStore = _CalendarEventStore with _$CalendarEventStore;

abstract class _CalendarEventStore with Store {
  ///To get the calendar details
  CalendarController controller = CalendarController();

  ///To get the note name for the event
  TextEditingController noteName = TextEditingController();

  ///To get the note desc for the event
  TextEditingController noteDesc = TextEditingController();

  ///To get the appointments
  List<dynamic> appointments = [];

  ///While adding we get the from date
  @observable
  DateTime? fromDate;

  ///To load the data once the event is added to a list
  @observable
  bool isLoading = false;

  ///To load the data from appointments in sf calendar package
  @observable
  bool isDataLoading = false;

  ///To get the appointments,date for that particular day
  @observable
  CalendarTapDetails calendarTapDetails =
      const CalendarTapDetails([], null, CalendarElement.viewHeader, null);

  ///To get the event details from the sf calendar package
  @action
  void calendarTapped(CalendarTapDetails tapDetails) {
    isDataLoading = true;
    calendarTapDetails = tapDetails;
    isDataLoading = false;
  }

  ///We pick the from date while adding note event
  Future pickFromDate(BuildContext context) async {
    final currentDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: fromDate ?? currentDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate != null) {
      fromDate = newDate;
    }
  }

  ///To add the event in a list
  @action
  void addEvent() {
    isLoading = true;
    final notes = NoteEventModel()
      ..noteTitle = noteName.text
      ..noteDesc = noteDesc.text
      ..eventDate = fromDate!;
    final noteBox = db.getNoteEvent();
    noteBox.add(notes);
    isLoading = false;
  }

  Future<bool?> showToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      webBgColor: 'linear-gradient(to right,#333333,#333333)',
      webPosition: 'center',
    );
  }
}
