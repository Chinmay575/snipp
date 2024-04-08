import 'dart:io';

Future createCleanArchitectureFiles() async {
  createDirectories();
  createDataFiles();
}

void createDirectories() {
  Directory('lib/src/data/models').createSync(recursive: true);
  Directory('lib/src/domain/repositories').createSync(recursive: true);
  Directory('lib/src/presentation/home/views').createSync(recursive: true);
  Directory('lib/src/presentation/error/views').createSync(recursive: true);
  Directory('lib/src/config').createSync(recursive: true);
  Directory('lib/src/utils/constants/strings').createSync(recursive: true);
}

void createDataFiles() {
// App Route data model

  File('lib/src/data/models/app_route.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class AppRoute {
  String name;
  Widget view;
  AppRoute({
    required this.name,
    required this.view,
  });
}

  ''');

// App Router

  File('lib/src/config/router.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import '../data/models/app_route.dart';
import '../presentation/error/views/error_page.dart';
import '../presentation/home/views/home_page.dart';
import '../utils/constants/strings/routes.dart';


class AppRouter {
  static init() async {}

  static List<AppRoute> _routes() => [
     AppRoute(
          name: Routes.home,
          view: HomePage(),
        ),
  ];

  static List allBlocProviders() => [];

  static PageRoute onGenerateRoute(RouteSettings settings) {
    if (settings.name != null) {
      Iterable<AppRoute> result =
          _routes().where((element) => element.name == settings.name);

      if (result.isNotEmpty) {
        return MaterialPageRoute(builder: (context) => result.first.view);
      }
    }
    return MaterialPageRoute(builder: (context) => ErrorPage());
  }
}


  ''');

// Home Page

  File('lib/src/presentation/home/views/home_page.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}


''');

// Error Page
  File('lib/src/presentation/error/views/error_page.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

''');

  File('lib/src/utils/constants/strings/routes.dart').writeAsStringSync('''

class Routes {
  static String home = '/';

  static String error = '/error';
}


''');

  File('lib/src/utils/constants/strings/assets.dart').writeAsStringSync('''

class Assets {
  
}


''');

  File('lib/main.dart').writeAsStringSync('''

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/config/router.dart';
import 'src/utils/constants/strings/routes.dart';

void main() async {
  await AppRouter.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppRouter.allBlocProviders()],
      child: ScreenUtilInit(
        designSize: const Size(1080, 1920),
        child: MaterialApp(
          title: 'Flutter',
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: Routes.home,
        ),
      ),
    );
  }
}


''');
}
