import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerceproject/screens/home-screen/view.dart';
import 'package:ecommerceproject/screens/login-screen/view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/Functions/cache/cache_helper.dart';
import '../../utils/constants/assets.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

late StreamSubscription<ConnectivityResult> subscription;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashTime();
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
              ? Get.off(() =>  LoginScreen())
              : Get.off(() => const HomeScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 47.w, left: 46.w, top: 170.h),
            child: Center(
                child: FadeIn(
              duration: const Duration(seconds: 1),
              child: SvgPicture.asset(AssetsPaths.logoSvg,
                  width: 500.w, height: 500.h),
            )),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
