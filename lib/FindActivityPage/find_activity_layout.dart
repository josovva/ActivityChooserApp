import 'package:flutter/material.dart';
import '../Repository/activity_database.dart';
import 'find_form.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key, required this.title, required this.db});

  final String title;
  final ActivityDataBase db;

  @override
  // ignore: no_logic_in_create_state
  State<FindPage> createState() => _FindPageState(db);
}

class _FindPageState extends State<FindPage> {
  _FindPageState(this.dataBase);

  final ActivityDataBase dataBase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FindActivityForm(db: dataBase),
      ),
    );
  }
}
