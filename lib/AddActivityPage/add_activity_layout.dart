import 'package:flutter/material.dart';
import '../Repository/activity_database.dart';
import 'add_form.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key, required this.title, required this.db});

  final String title;
  final ActivityDataBase db;

  @override
  // ignore: no_logic_in_create_state
  State<AddPage> createState() => _AddPageState(db);
}

class _AddPageState extends State<AddPage> {
  _AddPageState(this.dataBase);

  final ActivityDataBase dataBase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: AddActivityForm(db: dataBase),
      ),
    );
  }
}
