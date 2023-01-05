import 'package:activity_chooser_app/Repository/activity_database.dart';
import 'package:flutter/material.dart';

import '../FindActivityPage/find_activity_layout.dart';

class FindActivityButton extends StatelessWidget {
  const FindActivityButton({Key? key, required this.db}) : super(key: key);

  final ActivityDataBase db;
  @override
  Widget build(BuildContext context) {
    Route createRouteFindActivity() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FindPage(title: "Tell me what to do", db: db),
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

    return Center(
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
            child: const Text(
              'Tell me what to do!',
              textScaleFactor: 1.6,
            ),
            onPressed: () => Navigator.of(context).push(
                  createRouteFindActivity(),
                )),
      ),
    );
  }
}
