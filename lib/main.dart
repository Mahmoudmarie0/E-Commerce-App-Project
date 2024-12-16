import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/Functions/cache/cache_helper.dart'; // Ensure this file exists and is correctly configured.
import 'package:responsive_builder/responsive_builder.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(); // Initialize Firebase
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(
      desktop: 800,
      tablet: 450,
      watch: 200,
    ),
  );

  try {
    await CacheHelper.init();
  } catch (e) {
    print('CacheHelper initialization failed: $e');
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MainApp());
}
