import 'package:activity_chooser_app/Repository/activity_database.dart';
import 'package:flutter/material.dart';
import 'activity_tile.dart';

// ignore: must_be_immutable
class ActivityList extends StatelessWidget {
  ActivityList({
    Key? key,
    required this.db,
    required this.deleteActivityFunction,
    required this.editPageFunction,
    required this.makeActivityDoneFunction,
    required this.tagFilter,
  }) : super(key: key);

  final ActivityDataBase db;
  Function(int) deleteActivityFunction;
  Function(int) editPageFunction;
  Function(int) makeActivityDoneFunction;
  String tagFilter;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: db.getActivityListByTag(tagFilter).length,
      itemBuilder: (BuildContext context, int index) {
        return ActivityTile(
          item: db.getActivityListByTag(tagFilter)[index],
          deleteFun: deleteActivity,
          editFun: editActivity,
          doneFun: makeActivityDone,
          index: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  void deleteActivity(int index) {
    if (tagFilter != "all") {
      deleteActivityFunction
          .call(db.getIndexByActivityIndexWithTag(tagFilter, index));
    } else {
      deleteActivityFunction.call(index);
    }
  }

  void editActivity(int index) {
    if (tagFilter != "all") {
      editPageFunction
          .call(db.getIndexByActivityIndexWithTag(tagFilter, index));
    } else {
      editPageFunction.call(index);
    }
  }

  void makeActivityDone(int index) {
    if (tagFilter != "all") {
      makeActivityDoneFunction
          .call(db.getIndexByActivityIndexWithTag(tagFilter, index));
    } else {
      makeActivityDoneFunction.call(index);
    }
  }
}
