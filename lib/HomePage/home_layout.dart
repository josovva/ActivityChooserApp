import 'package:activity_chooser_app/EditActivityPage/edit_activity_layout.dart';
import 'package:activity_chooser_app/HomePage/find_activity_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Activity_ListView/activity_list.dart';
import '../AddActivityPage/add_activity_layout.dart';
import '../Repository/activity_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _activityBox = Hive.box('storageActivities');
  final _activityDB = ActivityDataBase();

  String tagFilter = "all";
  List<DropdownMenuItem<String>> tagList = [];

  @override
  void initState() {
    if (_activityBox.get("activity_list") == null) {
      _activityDB.initDataBase();
    } else {
      _activityDB.loadData();
    }

    tagList = _activityDB.tagList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
    tagList
        .add(const DropdownMenuItem<String>(value: "all", child: Text("all")));

    super.initState();
  }

  Future refresh() async {
    setState(() => _activityDB.loadData());
  }

  void changePage(int index) {
    Navigator.of(context)
        .push(
          _createRouteEditActivity(index),
        )
        .then((val) => refresh());
  }

  void makeActivityDone(int index) {
    _activityDB.activityList[index].ifDone =
        !_activityDB.activityList[index].ifDone;
    refresh();
  }

  Future<void> deleteActivityDialogBox(int index) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete activity'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text(
                    'Are you sure that you want to delete this activity?'),
                Text(
                  '${_activityDB.activityList[index].name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Decline'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Accept'),
              onPressed: () {
                _activityDB.activityList.removeAt(index);
                _activityDB.updateDataBase();
                refresh();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Route _createRouteAddActivity() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          AddPage(title: "Add new activity", db: _activityDB),
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

  Route _createRouteEditActivity(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          EditPage(title: "Edit activity", db: _activityDB, index: index),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: FindActivityButton(db: _activityDB),
          ),
          DropdownButton<String>(
            value: tagFilter,
            underline: Container(
              height: 2,
              color: Colors.teal,
            ),
            onChanged: (String? value) {
              setState(() {
                tagFilter = value!;
              });
            },
            items: tagList,
          ),
          Expanded(
              flex: 7,
              child: ActivityList(
                db: _activityDB,
                deleteActivityFunction: deleteActivityDialogBox,
                editPageFunction: changePage,
                makeActivityDoneFunction: makeActivityDone,
                tagFilter: tagFilter,
              )),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(
              _createRouteAddActivity(),
            )
            .then((val) => refresh()),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
