import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/src/providers/articles_provider.dart';
import 'package:identitic/src/providers/sockets_provider.dart';
import 'package:identitic/src/providers/auth_provider.dart';
import 'package:identitic/src/providers/events_provider.dart';
import 'package:identitic/src/providers/grades_provider.dart';
import 'package:identitic/src/providers/inattendances_provider.dart';
import 'package:identitic/src/ui/widgets/theme.dart';
import 'package:identitic/src/utils/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<InattendancesProvider>(
          create: (_) => InattendancesProvider(),
        ),
        ChangeNotifierProvider<GradesProvider>(
          create: (_) => GradesProvider(),
        ),
        ChangeNotifierProvider<EventsProvider>(
          create: (_) => EventsProvider(),
        ),
        ChangeNotifierProvider<ArticlesProvider>(
          create: (_) => ArticlesProvider(),
        ),
        ChangeNotifierProvider<SocketsProvider>(
          create: (_) => SocketsProvider(),
        )
      ],
      child: MaterialApp(
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
