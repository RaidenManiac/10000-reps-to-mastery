import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/mastery_screen.dart';
import 'state/skill_controller.dart';
import 'storage/skill_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final storage = SharedPreferencesSkillStorage(preferences);
  final controller = SkillController(storage: storage);
  await controller.initialize();

  runApp(RepsApp(controller: controller));
}

class RepsApp extends StatelessWidget {
  const RepsApp({required this.controller, super.key});

  final SkillController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10,000 Reps to Mastery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF206A5D),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAF7),
        useMaterial3: true,
      ),
      home: MasteryScreen(controller: controller),
    );
  }
}
