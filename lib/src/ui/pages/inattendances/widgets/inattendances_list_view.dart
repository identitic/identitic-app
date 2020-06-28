import 'package:flutter/material.dart';

import 'package:identitic/src/models/inattendance.dart';
import 'package:identitic/src/ui/pages/inattendances/widgets/inattendance_list_tile.dart';
import 'package:identitic/src/providers/inattendances_provider.dart';
import 'package:provider/provider.dart';

class InattendancesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<InattendancesProvider>(
        builder: (_, InattendancesProvider inattendancesProvider, __) {
      return ListView.separated(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: inattendancesProvider.inattendances.isNotEmpty
            ? inattendancesProvider.inattendances.length
            : 2,
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, int i) {
          return SizedBox(height: 8);
        },
        itemBuilder: (_, int i) {
          Inattendance inattendance =
              inattendancesProvider.inattendances.isNotEmpty
                  ? inattendancesProvider.inattendances[i]
                  : null;
          return InattendanceListTile(inattendance);
        },
      );
    });
  }
}
