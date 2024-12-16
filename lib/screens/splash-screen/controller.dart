import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerceproject/screens/home-screen/view.dart';
import 'package:ecommerceproject/screens/login-screen/view.dart';

import 'package:get/get.dart';

import '../../utils/Functions/cache/cache_helper.dart';

late StreamSubscription<ConnectivityResult> subscription;

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    splashTime();
    super.onInit();
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  Future<void> splashTime() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('=====Called onConnectivityChanged');
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        // I am connected to a mobile network.
        Timer(const Duration(seconds: 2), () {
          CacheHelper().getData(key: "Login") == true
              ? Get.off(() => const LoginScreen())
              : Get.off(() => const HomeScreen());
        });
      }
      update();
    });
  }
}
