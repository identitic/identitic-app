import 'package:flutter/material.dart';
import 'package:identitic/providers/inattendances_provider.dart';

import 'package:identitic/pages/inattendances/widgets/inattendances_list_view.dart';
import 'package:provider/provider.dart';

class StudentInattendancesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inasistencias'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.pink,
                  radius: MediaQuery.of(context).size.width / 8,
                  child: Consumer<InattendancesProvider>(
                    builder:
                        (_, InattendancesProvider inattendancesProvider, __) {
                      return Text(
                        inattendancesProvider.inattendances?.length
                                ?.toString() ??
                            '...',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Inasistencias totales',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: InattendancesListView(),
          ),
        ],
      ),
    );
  }
}
