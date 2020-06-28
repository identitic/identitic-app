import 'package:flutter/material.dart';
import 'package:identitic/src/providers/events_provider.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:identitic/src/ui/pages/home/widgets/events_list_view.dart';
import 'package:identitic/src/ui/pages/home/widgets/identitic_circle.dart';
import 'package:identitic/src/utils/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('IDENTITIC', style: TextStyle(fontSize: 16),), //TODO: refactory
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteName.messages),
            icon: Icon(OMIcons.chatBubbleOutline),
            tooltip: 'Mensajes',
          ),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () =>
              Provider.of<EventsProvider>(context, listen: false).fetchEvents(/* Provider.of<AuthProvider>(context, listen: false).user */),
          child: ListView(
            padding: EdgeInsets.all(16),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IdentiticCircle(
                    onTap: () => Navigator.pushNamed(context, RouteName.grades),
                    child: Icon(OMIcons.classIcon, size: 44),
                    text: "Calificaciones",
                  ),
                  IdentiticCircle(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteName.inattendances),
                    child: Icon(OMIcons.check, size: 44),
                    text: "Inasistencias",
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IdentiticCircle(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteName.families),
                    child: Icon(OMIcons.peopleOutline, size: 44),
                    text: "Familias",
                  ),
                  IdentiticCircle(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteName.tasks),
                    child: Icon(OMIcons.assignment, size: 46),
                    text: "Tareas",
                  ),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Próximos eventos'),
              ),
              EventsListView(),
            ],
          ),
        ),
      ),
    );
  }
}
