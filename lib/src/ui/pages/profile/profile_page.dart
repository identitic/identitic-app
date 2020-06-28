import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:identitic/src/providers/auth_provider.dart';
import 'package:identitic/src/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Perfil', style: TextStyle(fontSize: 16),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, RouteName.sign_in, (_) => false),
            icon: Icon(OMIcons.exitToApp),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 8,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    Provider.of<AuthProvider>(context, listen: false).user.lastName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    Provider.of<AuthProvider>(context, listen: false).user.name,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
