import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:identitic/providers/classes_provider.dart';
import 'package:identitic/providers/profilephoto_provider.dart';
import 'package:identitic/providers/students_provider.dart';
// import 'package:identitic/utils/themes.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/providers/events_provider.dart';
import 'package:identitic/providers/grades_provider.dart';
import 'package:identitic/providers/inattendances_provider.dart';
import 'package:identitic/providers/notifications_provider.dart';
// import 'package:identitic/widgets/theme.dart';
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
      systemNavigationBarColor: Colors.white,
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
        Provider<NotificationsProvider>(
          create: (_) => NotificationsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<ProfilePhotoProvider>(
          create: (_) => ProfilePhotoProvider()),
        ChangeNotifierProvider<InattendancesProvider>(
          create: (_) => InattendancesProvider(),
        ),
        ChangeNotifierProvider<GradesProvider>(
          create: (_) => GradesProvider(),
        ),
        ChangeNotifierProvider<EventsProvider>(
          create: (_) => EventsProvider(),
        ),
        ChangeNotifierProvider<ClassesProvider>(
          create: (_) => ClassesProvider(),
        ),
        ChangeNotifierProvider<StudentsProvider>(
          create: (_) => StudentsProvider(),
        ),
        ChangeNotifierProvider<ArticlesProvider>(
          create: (_) => ArticlesProvider(),
        ),
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
            button: TextStyle(fontSize: 16),
            subtitle1: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 18, // Only for secondary pages, main pages use 24px
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
            selectedItemColor: Colors.pink,
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
        ),
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
