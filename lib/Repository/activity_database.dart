import 'package:hive_flutter/hive_flutter.dart';

import '../Activity_ListView/activity.dart';

class ActivityDataBase {
  List<dynamic> activityList = [];
  List<String> tagList = <String>[
    'book',
    'friends',
    'fun',
    'movie',
    'sport',
    'work',
    'other'
  ];

  final _activityBox = Hive.box('storageActivities');

  void initDataBase() {
    activityList = [
      Activity(name: "Avatar", hours: 3, tag: "movie"),
      Activity(name: "Walking", hours: 1, tag: "sport"),
      Activity(name: "Interstellar", hours: 2, minutes: 30, tag: "movie"),
      Activity(name: "1984", tag: "book")
    ];
    _activityBox.put("activity_list", activityList);
  }

  void loadData() {
    activityList = _activityBox.get("activity_list");
  }

  void updateDataBase() {
    _activityBox.put("activity_list", activityList);
  }

  List<dynamic> getActivityListByTag(String tag) {
    List<dynamic> newList = [];
    if (tag == "all") return activityList;

    for (int i = 0; i < activityList.length; i++) {
      if (activityList[i].tag == tag) newList.add(activityList[i]);
    }

    return newList;
  }

  int getIndexByActivityIndexWithTag(String tag, int index) {
    var activity = getActivityListByTag(tag)[index];
    for (int i = 0; i < activityList.length; i++) {
      if (activityList[i].name == activity.name &&
          activityList[i].tag == activity.tag &&
          activityList[i].hours == activity.hours &&
          activityList[i].minutes == activity.minutes &&
          activityList[i].rating == activity.rating &&
          activityList[i].ifDone == activity.ifDone) return i;
    }
    return -1;
  }
}
