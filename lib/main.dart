import 'package:flutter/material.dart';
import 'package:notes_reminder_app/features/calender_event/stores/calendar_event_store.dart';
import 'package:provider/provider.dart';

import 'core/db/db.dart';
import 'features/calender_event/screens/show_calendar_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await db.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<CalendarEventStore>(
            create: (_) => CalendarEventStore(),
          ),
        ],
        child: MaterialApp(
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: const ShowCalendarEvent()));
  }
}
