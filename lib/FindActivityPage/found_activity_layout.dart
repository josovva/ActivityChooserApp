import 'dart:math';
import 'package:flutter/material.dart';
import '../Repository/activity_database.dart';

class FoundPage extends StatefulWidget {
  const FoundPage(
      {super.key,
      required this.title,
      required this.db,
      required this.hours,
      required this.minutes,
      required this.tag});

  final String title;
  final ActivityDataBase db;
  final int hours;
  final int minutes;
  final String tag;

  @override
  // ignore: no_logic_in_create_state
  State<FoundPage> createState() => _FoundPageState(db, hours, minutes, tag);
}

class _FoundPageState extends State<FoundPage> {
  _FoundPageState(this.dataBase, this._hours, this._minutes, this._tag);

  final ActivityDataBase dataBase;
  final int _hours;
  final int _minutes;
  final String _tag;

  @override
  Widget build(BuildContext context) {
    var index = getRandomActivityIndex(_hours, _minutes, _tag);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Your activity is:",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 32),
            if (index == -1)
              const Text(
                "There's nothing you can do with this requirements :(",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )
            else
              Column(children: [
                Text(
                  dataBase.activityList[index].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(dataBase.activityList[index].tag,
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    )),
                const SizedBox(height: 8),
                const Text("It will last:",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                const SizedBox(height: 8),
                if (dataBase.activityList[index].hours == 0 &&
                    dataBase.activityList[index].minutes == 0 &&
                    _hours == 0 &&
                    _minutes == 0)
                  const Text("It will not have time limit.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))
                else if (dataBase.activityList[index].hours == 0 &&
                    dataBase.activityList[index].minutes == 0)
                  Text("$_hours h $_minutes min",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))
                else
                  Text(
                      "${dataBase.activityList[index].hours} h ${dataBase.activityList[index].minutes} min",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))
              ]),
            const SizedBox(height: 32),
            SizedBox(
              height: 60,
              width: 120,
              child: ElevatedButton(
                  onPressed: () => {setState(() => {})},
                  child: const Text("ReRoll",
                      style: TextStyle(
                        fontSize: 24,
                      ))),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 60,
              width: 300,
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Text("I am going to do this!",
                      style: TextStyle(
                        fontSize: 24,
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  int getRandomActivityIndex(int hours, int minutes, String tag) {
    var list = dataBase.activityList;
    List<int> listOfIndexes = [];
    for (int i = 0; i < dataBase.activityList.length; i++) {
      var activity = list[i];
      // ignore: unrelated_type_equality_checks
      if (activity.ifDone == false &&
          ((hours == 0 && minutes == 0) ||
              (activity.hours == 0 && activity.minutes == 0) ||
              (activity.hours < hours ||
                  (activity.hours == hours && activity.minutes <= minutes))) &&
          (tag == "doesn't matter" || activity.tag == tag)) {
        for (int j = 0; j < activity.rating; j++) {
          listOfIndexes.add(i);
        }
      }
    }

    if (listOfIndexes.isEmpty) return -1;

    var rng = Random();
    return listOfIndexes[rng.nextInt(listOfIndexes.length)];
  }
}
