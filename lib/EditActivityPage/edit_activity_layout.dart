import 'package:flutter/material.dart';
import '../Repository/activity_database.dart';
import 'edit_form.dart';

class EditPage extends StatefulWidget {
  const EditPage(
      {super.key, required this.title, required this.db, required this.index});

  final String title;
  final ActivityDataBase db;
  final int index;

  @override
  // ignore: no_logic_in_create_state
  State<EditPage> createState() => _EditPageState(db, index);
}

class _EditPageState extends State<EditPage> {
  _EditPageState(this.dataBase, this.index);

  final ActivityDataBase dataBase;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: EditActivityForm(db: dataBase, index: index),
      ),
    );
  }
}
