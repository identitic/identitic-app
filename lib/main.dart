import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:identitic/utils/themes.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/providers/sockets_provider.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/providers/grades_provider.dart';
import 'package:identitic/providers/inattendances_provider.dart';
import 'package:identitic/widgets/theme.dart';
import 'package:identitic/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xfffafafa),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  // await Future.delayed(Duration(seconds: 10));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
          create: (_) => AuthProvider(),
          lazy: false,
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashFactory: InkRipple.splashFactory,
          highlightColor: Colors.transparent,
          primaryColor: Colors.white,
          primaryColorBrightness: Brightness.light,
          accentColor: Colors.pink,
          accentColorBrightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            subtitle1: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey.withOpacity(.5),
            selectedItemColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          buttonColor: Colors.pink,
          buttonTheme: ButtonThemeData(
            minWidth: 56,
            height: 56,
            highlightColor: Colors.transparent,
            shape: StadiumBorder(),
            padding: const EdgeInsets.all(16),
            textTheme: ButtonTextTheme.normal,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
