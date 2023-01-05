import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Activity {
  Activity(
      {required this.name,
      this.hours = 0,
      this.minutes = 0,
      required this.tag,
      this.rating = 1,
      this.ifDone = false});

  @HiveField(0)
  final String name;
  @HiveField(1)
  final int hours;
  @HiveField(2)
  final int minutes;
  @HiveField(3)
  final String tag;
  @HiveField(4)
  final int rating;
  @HiveField(5)
  bool ifDone;
}
