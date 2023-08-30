import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speciality_coffee_review/firebase_options.dart';
import 'package:speciality_coffee_review/screens/authentication.dart';

void main() async {
  // Locking the device orientation to portrait only.
  WidgetsFlutterBinding.ensureInitialized();
  // initializing Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: CoffeeApp()));
}

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 78, 37, 1),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.senTextTheme(),
);

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: theme,
      themeMode: ThemeMode.dark,
      home: const AuthenticationScreen(),
    );
  }
}
