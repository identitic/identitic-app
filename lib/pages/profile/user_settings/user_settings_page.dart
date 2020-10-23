import 'package:flutter/material.dart';

import 'package:identitic/models/user.dart';
import 'package:provider/provider.dart';

import 'package:identitic/providers/auth_provider.dart';
// import 'package:identitic/pages/profile/widgets/profile_modal.dart';

class UserSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text('Perfil', style: TextStyle(fontSize: 24)),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GestureDetector(
                        // onTap: () => showProfileModalBottomSheet(context),
                        child: const CircleAvatar(
                          radius: 56,
                          backgroundImage:
                              AssetImage('assets/images/profile_picture.jpg'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${context.watch<AuthProvider>().user.name} ${context.watch<AuthProvider>().user.lastName}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.watch<AuthProvider>().user.hierarchy ==
                                UserHierarchy.teacher
                            ? 'Profesor/a'
                            : 'Alumno/a',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
