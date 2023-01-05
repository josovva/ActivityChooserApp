import 'package:activity_chooser_app/Activity_ListView/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ActivityTile extends StatelessWidget {
  ActivityTile(
      {Key? key,
      required this.item,
      required this.deleteFun,
      required this.editFun,
      required this.doneFun,
      required this.index})
      : super(key: key);

  final Activity item;
  Function(int) deleteFun;
  Function(int) editFun;
  Function(int) doneFun;

  int index;

  void _deleteFunction(BuildContext context) {
    deleteFun.call(index);
  }

  void _editFunction(BuildContext context) {
    editFun.call(index);
  }

  void _doneFunction(BuildContext context) {
    doneFun.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: _deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.teal.shade600,
              borderRadius: BorderRadius.circular(5),
            ),
            SlidableAction(
              onPressed: _editFunction,
              icon: Icons.edit,
              backgroundColor: Colors.teal.shade500,
              borderRadius: BorderRadius.circular(5),
            ),
            SlidableAction(
              onPressed: _doneFunction,
              icon: Icons.check,
              backgroundColor: Colors.teal.shade400,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.ifDone == false)
                    RichText(
                      text: TextSpan(
                        text: item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' (${item.tag})',
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  if (item.ifDone == true)
                    Text("${item.name} (${item.tag})",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough)),
                  const SizedBox(height: 5),
                  if (item.ifDone == true)
                    const Text("Done.")
                  else if (item.hours == 0 && item.minutes == 0)
                    const Text("There's no time limit")
                  else if (item.minutes == 0 && item.hours > 1)
                    Text("${item.hours} hours")
                  else if (item.minutes == 0)
                    Text("${item.hours} hour")
                  else if (item.hours == 0 && item.minutes > 1)
                    Text("${item.minutes} minutes")
                  else if (item.hours == 0)
                    Text("${item.minutes} minute")
                  else if (item.hours <= 1 && item.minutes > 1)
                    Text("${item.hours} hour ${item.minutes} minutes")
                  else if (item.hours <= 1)
                    Text("${item.hours} hour ${item.minutes} minute")
                  else if (item.minutes > 1)
                    Text("${item.hours} hour ${item.minutes} minutes")
                  else
                    Text("${item.hours} hours ${item.minutes} minutes"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
