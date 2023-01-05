import 'package:activity_chooser_app/Activity_ListView/activity.dart';
import 'package:hive/hive.dart';

class ActivityAdapter extends TypeAdapter<Activity> {
  @override
  final typeId = 0;

  @override
  Activity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Activity(
        name: fields[0] as String,
        hours: fields[1] as int,
        minutes: fields[2] as int,
        tag: fields[3] as String,
        rating: fields[4] as int,
        ifDone: fields[5] as bool);
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.hours)
      ..writeByte(2)
      ..write(obj.minutes)
      ..writeByte(3)
      ..write(obj.tag)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.ifDone);
  }
}
