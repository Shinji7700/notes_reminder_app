import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notes_reminder_app/features/calender_event/stores/calendar_event_store.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarEventStore = context.read<CalendarEventStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Event',
        ),
        toolbarHeight: 60,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),

              //To enter the note name
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Note Title:",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: calendarEventStore.noteName,
                  decoration: const InputDecoration(hintText: "Note Title"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //To enter the note desc
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Note Description:",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: calendarEventStore.noteDesc,
                  decoration: const InputDecoration(hintText: "Note Desc"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //To choose the from date that the note must start
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Choose the date:",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  calendarEventStore.pickFromDate(context);
                },
                child: Observer(
                  builder: (_) => Center(
                    child: Text(
                      calendarEventStore.fromDate == null
                          ? 'Choose Date'
                          : "${calendarEventStore.fromDate!.day}.${calendarEventStore.fromDate!.month}.${calendarEventStore.fromDate!.year}",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //To add all of the above details into hive
              Center(
                child: TextButton(
                  onPressed: () {
                    if (calendarEventStore.noteName.text == '') {
                      calendarEventStore.showToast('Please enter a note name');
                    } else if (calendarEventStore.noteDesc.text == '') {
                      calendarEventStore
                          .showToast('Please enter the note desc');
                    } else if (calendarEventStore.fromDate == null) {
                      calendarEventStore
                          .showToast('Please select the from date');
                    } else {
                      calendarEventStore.addEvent();
                      Navigator.pop(context);
                      calendarEventStore.showToast('Data has been uploaded');
                      calendarEventStore.noteName.clear();
                      calendarEventStore.noteDesc.clear();
                      calendarEventStore.fromDate == null;
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
