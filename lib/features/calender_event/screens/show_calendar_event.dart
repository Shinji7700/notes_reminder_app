// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:notes_reminder_app/core/db/db.dart';
// import 'package:notes_reminder_app/core/db/model/note_event_model.dart';
// import 'package:notes_reminder_app/features/calender_event/screens/add_event.dart';
// import 'package:notes_reminder_app/features/calender_event/stores/calendar_event_store.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class ShowCalendarEvent extends StatefulWidget {
//   const ShowCalendarEvent({Key? key}) : super(key: key);
//
//   @override
//   State<ShowCalendarEvent> createState() => _ShowCalendarEventState();
// }
//
// class _ShowCalendarEventState extends State<ShowCalendarEvent> {
//   Map<DateTime, List<dynamic>> _events;
//   List<dynamic> _selectedEvents;
//   @override
//   void initState() {
//     super.initState();
//     _events = {};
//     _selectedEvents = [];
//   }
//   @override
//   Widget build(BuildContext context) {
//     final calendarEventStore = context.read<CalendarEventStore>();
//
//     return Scaffold(
//       body: Observer(builder: (_) {
//         if (calendarEventStore.isLoading) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.white,
//             ),
//           );
//         } else {
//           return ValueListenableBuilder<Box<NoteEventModel>>(
//               valueListenable: db.getNoteEvent().listenable(),
//               builder: (context, box, _) {
//                 var selectedEvents = box.values.toList().cast<NoteEventModel>();
//                 return Column(
//                   children: [
//                     TableCalendar(
//                       eventLoader: (day) {
//                         return selectedEvents;
//                       },
//                       firstDay: DateTime.utc(2010, 10, 16),
//                       lastDay: DateTime.utc(2030, 3, 14),
//                       focusedDay: calendarEventStore.focusedDayMobx,
//                       calendarFormat: calendarEventStore.calendarFormat,
//                       headerStyle: const HeaderStyle(
//                           formatButtonVisible: false, titleCentered: true),
//                       selectedDayPredicate: (day) {
//                         return calendarEventStore.isSameDayPredicate(day);
//                       },
//                       onDaySelected: (selectedDay, focusedDay) {
//                         calendarEventStore.onDaySelected(
//                             selectedDay, focusedDay);
//                       },
//                       onFormatChanged: (format) {
//                         calendarEventStore.onFormatChanged(format);
//                       },
//                       onPageChanged: (focusedDay) {
//                         calendarEventStore.focusedDayMobx = focusedDay;
//                       },
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                           itemCount: selectedEvents.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(selectedEvents[index].noteTitle),
//                               subtitle: Text(selectedEvents[index].noteDesc),
//                             );
//                           }),
//                     )
//                   ],
//                 );
//               });
//         }
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const AddEvent()));
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_reminder_app/core/db/db.dart';
import 'package:notes_reminder_app/core/db/model/note_event_model.dart';
import 'package:notes_reminder_app/features/calender_event/stores/calendar_event_store.dart';
import 'package:notes_reminder_app/features/calender_event/widgets/events_data_source.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'add_event.dart';

class ShowCalendarEvent extends StatelessWidget {
  const ShowCalendarEvent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final calendarEventStore = context.read<CalendarEventStore>();
    return Scaffold(
      body: Observer(builder: (_) {
        if (calendarEventStore.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else {
          return ValueListenableBuilder<Box<NoteEventModel>>(
              valueListenable: db.getNoteEvent().listenable(),
              builder: (context, box, _) {
                List<NoteEventModel> selectedEvents =
                    box.values.toList().cast<NoteEventModel>();
                return Observer(
                  builder: (_) => Column(
                    children: [
                      MouseRegion(
                        onHover: (PointerHoverEvent event) {
                          CalendarDetails? details = calendarEventStore
                              .controller
                              .getCalendarDetailsAtOffset!(event.localPosition);
                          calendarEventStore.appointments =
                              details!.appointments!;
                        },
                        child: SfCalendar(
                          headerHeight: 100,
                          controller: calendarEventStore.controller,
                          dataSource: EventsDataSource(selectedEvents),
                          view: CalendarView.month,
                          onTap: (details) {
                            calendarEventStore.calendarTapped(details);
                          },
                          // onLongPress: (details) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               EventInfo(calendarTapDetails: details)));
                          // },
                          // monthViewSettings: const MonthViewSettings(showAgenda: true),
                          initialDisplayDate: DateTime.now(),
                          cellBorderColor: Colors.transparent,
                        ),
                      ),
                      calendarEventStore.isDataLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : calendarEventStore
                                  .calendarTapDetails.appointments!.isEmpty
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: Text('No events'),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount:
                                      calendarEventStore.appointments.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ListTile(
                                            title: Text(calendarEventStore
                                                .appointments[index].noteTitle),
                                            subtitle: Text(calendarEventStore
                                                .appointments[index].noteDesc),
                                          )),
                                    );
                                  })
                    ],
                  ),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          calendarEventStore.noteName.clear();
          calendarEventStore.noteDesc.clear();
          calendarEventStore.fromDate = null;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEvent()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
