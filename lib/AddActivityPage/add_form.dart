import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:numberpicker/numberpicker.dart';
import '../Activity_ListView/activity.dart';
import '../Repository/activity_database.dart';

// Define a custom Form widget.
class AddActivityForm extends StatefulWidget {
  const AddActivityForm({super.key, required this.db});

  final ActivityDataBase db;

  @override
  AddActivityFormState createState() {
    // ignore: no_logic_in_create_state
    return AddActivityFormState(db);
  }
}

class AddActivityFormState extends State<AddActivityForm> {
  final _formKey = GlobalKey<FormState>();

  int _hours = 0;
  int _minutes = 0;
  String dropdownValue = 'book';
  int _rating = 1;
  final ActivityDataBase db;

  String _name = "";

  AddActivityFormState(this.db);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              const Text("Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of an activity!';
                    } else {
                      _name = value;
                    }
                    return null;
                  },
                  maxLength: 50,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const Text("Duration",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  const Text("Activity will not have a time limit.")
                else
                  Text(
                      "Activity will last $_hours hours and $_minutes minutes.")
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const Text("Type of activity",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  items:
                      db.tagList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const Text("Rate an activity",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 16,
                ),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.teal,
                  ),
                  onRatingUpdate: (rating) {
                    _rating = rating.toInt();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Activities with a higher rating will be chosen more commonly.",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              height: 60,
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    db.activityList.add(Activity(
                        name: _name,
                        tag: dropdownValue,
                        hours: _hours,
                        minutes: _minutes,
                        rating: _rating));
                    db.updateDataBase();
                    Navigator.pop(context, true);
                  }
                },
                child: const Text(
                  'Submit',
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
