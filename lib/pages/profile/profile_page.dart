import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:identitic/models/user.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:identitic/providers/auth_provider.dart';
// import 'package:identitic/pages/profile/widgets/profile_modal.dart';
import 'package:identitic/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text('Perfil', style: TextStyle(fontSize: 24)),
            actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () => _signOut(context),
              ),
            ],
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
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.accents[0],
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Datos personales'),
                  // onTap: () => Navigator.pushNamed(context, RouteName.business),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.accents[1],
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Ajustes'),
                  // onTap: () => Navigator.pushNamed(context, RouteName.settings),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.accents[2],
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Soporte'),
                  onTap: _launchSupport,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await context.read<AuthProvider>().signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteName.onboarding,
      (_) => false,
    );
  }

  Future<void> _launchSupport() async {
    const String url = 'https://wa.me/5491122548189';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
