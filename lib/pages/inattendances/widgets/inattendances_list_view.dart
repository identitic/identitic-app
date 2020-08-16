import 'package:flutter/material.dart';

import 'package:identitic/models/inattendance.dart';
import 'package:identitic/pages/inattendances/widgets/inattendance_list_tile.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/inattendances_provider.dart';
import 'package:provider/provider.dart';

class InattendancesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<InattendancesProvider>(context, listen: false)
            .fetchInattendances(
                Provider.of<AuthProvider>(context, listen: false).user.id),
        builder: (_, AsyncSnapshot snapshot) {
          final List<Inattendance> _inattendances = snapshot.data;
          if (snapshot.hasData) {
            return ListView.separated(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _inattendances.length,
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, int i) {
                  return SizedBox(height: 8);
                },
                itemBuilder: (_, int i) {
                  return InattendanceListTile(_inattendances[i]);
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
