import 'package:activity_chooser_app/FindActivityPage/found_activity_layout.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../Repository/activity_database.dart';

class FindActivityForm extends StatefulWidget {
  const FindActivityForm({super.key, required this.db});

  final ActivityDataBase db;

  @override
  FindActivityFormState createState() {
    // ignore: no_logic_in_create_state
    return FindActivityFormState(db);
  }
}

class FindActivityFormState extends State<FindActivityForm> {
  final _formKey = GlobalKey<FormState>();

  int _hours = 0;
  int _minutes = 0;
  String dropdownValue = "doesn't matter";

  final ActivityDataBase db;

  FindActivityFormState(this.db);

  Route _createRoute(ActivityDataBase activityDB) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FoundPage(
        title: "Add new activity",
        db: db,
        hours: _hours,
        minutes: _minutes,
        tag: dropdownValue,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = db.tagList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
    list.add(
      const DropdownMenuItem(
        value: "doesn't matter",
        child: Text("doesn't matter"),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text("How much time do you have to spare?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                value: _hours,
                minValue: 0,
                maxValue: 23,
                onChanged: (value) => setState(() => _hours = value),
              ),
              const Text("H"),
              NumberPicker(
                value: _minutes,
                minValue: 0,
                maxValue: 59,
                onChanged: (value) => setState(() => _minutes = value),
              ),
              const Text("MIN"),
            ],
          ),
          if (_hours == 0 && _minutes == 0)
            const Text("Time limit not set.")
          else
            Text("You have $_hours hours and $_minutes minutes."),
          const SizedBox(
            height: 32,
          ),
          const Text("Type of activity",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: dropdownValue,
            underline: Container(
              height: 2,
              color: Colors.teal,
            ),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list,
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context)
                        .push(
                          _createRoute(db),
                        )
                        .then((val) => Navigator.of(context).pop());
                  }
                },
                child: const Text(
                  'Tell me what to do!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
