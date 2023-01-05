import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'HomePage/home_layout.dart';
import 'Repository/activity_adapter.dart.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ActivityAdapter());

  // ignore: unused_local_variable
  await Hive.openBox('storageActivities');

  runApp(const ActivityChooserApp());
}

class ActivityChooserApp extends StatelessWidget {
  const ActivityChooserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Chooser',
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const HomePage(title: 'Activity Chooser'),
      // },
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(title: 'Activity Chooser'),
    );
  }
}
