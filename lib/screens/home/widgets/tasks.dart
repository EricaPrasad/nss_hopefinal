import 'package:flutter/cupertino.dart';

import '../../../models/task.dart';

class Tasks extends StatelessWidget {
final taskList=Task.generateTask();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Task list'),

    );
  }
}
