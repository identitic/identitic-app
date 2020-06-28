
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:identitic/src/providers/inattendances_provider.dart';
import 'package:identitic/src/ui/pages/inattendances_teacher/widgets/teacher_inattendance_list_tile.dart';

class InattendancesListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<InattendancesProvider>(
      builder: (_, InattendancesProvider inattendancesProvider, __) {
        return ListView.separated(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: inattendancesProvider.inattendances.length,
          padding: EdgeInsets.all(16),
          separatorBuilder: (_, __) {
            return SizedBox(height: 8);
          },
          itemBuilder: (_, int i) {
            return InattendanceTeacherListTile();
          },
        );
      },
    );
  }
}


