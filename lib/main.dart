import 'package:flutter/material.dart';
import 'package:moshf_quran/models/database.dart';
import 'package:moshf_quran/views/pages/sora_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await QuranDB.initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SoraScreen());
  }
}
