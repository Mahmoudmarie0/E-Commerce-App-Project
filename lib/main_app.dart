import 'package:ecommerceproject/firebase_options.dart';
import 'package:ecommerceproject/providers/admin-provider.dart';
import 'package:ecommerceproject/providers/cart_provider.dart'; // Import CartProvider
import 'package:ecommerceproject/screens/home-screen/view.dart';
import 'package:ecommerceproject/screens/login-screen/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'screens/admin/controller.dart';
import 'screens/user/user-home/view.dart';
import 'utils/Functions/cache/cache_helper.dart';
import 'utils/constants/styles_and_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await _initializeFirebase();
  await GetStorage.init();

  // Set System UI Overlay
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Set Custom Breakpoints for Responsiveness
  _setCustomBreakpoints();

  // Initialize CacheHelper
  await _initializeCacheHelper();

  // Force Portrait Orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(AdminController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()), // Add CartProvider
      ],
      child: const MainApp(),
    ),
  );
}

// Firebase initialization with error handling
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("Firebase initialized successfully.");
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
  }
}

// CacheHelper initialization with error handling
Future<void> _initializeCacheHelper() async {
  try {
    await CacheHelper.init();
    debugPrint("CacheHelper initialized successfully.");
  } catch (e) {
    debugPrint("CacheHelper initialization failed: $e");
  }
}

// Set custom breakpoints for responsiveness
void _setCustomBreakpoints() {
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(
      desktop: 800,
      tablet: 450,
      watch: 200,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRemembered = CacheHelper.sharedPreferences.getBool('rememberMe') ?? false;
    return GetMaterialApp(
      title: "ECommerce",
      theme: Styles.themeData(isDarkTheme: false, context: context),
      locale: const Locale("en", "US"),
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        ScreenUtil.init(
          context,
          designSize: const Size(360, 690),
          minTextAdapt: true,
        );
        return widget!;
      },
      home: isRemembered ? HomeScreen() : LoginScreen(),
    );
  }
}
