import 'package:app8/firebase_options.dart';
import 'package:app8/pages/login_page.dart';
import 'package:app8/services/alert_service.dart';
import 'package:app8/services/auth_service.dart';
import 'package:app8/services/database_service.dart';
import 'package:app8/services/media_service.dart';
import 'package:app8/services/navigation_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyAQj9QgTwlJB2yGTMG0SMQXNd1v-thJKqA",
    projectId: "fir-chat-app-c3c91",
    messagingSenderId: "829557535874",
    appId: "1:829557535874:web:142dfe5595b547d461709b",
  ));
  await registerServices();

  runApp(MyApp());
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<AlertService>(
    AlertService(),
  );
  getIt.registerSingleton<MediaService>(
    MediaService(),
  );
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;
  late AuthService _authService;

  MyApp({super.key}) {
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: _authService.user != null ? "/home" : "/login",
      routes: _navigationService.routes,
    );
  }
}
