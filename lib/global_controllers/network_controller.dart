import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerceproject/screens/noconnection-screen/view.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void onInit() {
    super.onInit();
    watchNetworkState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  Future<void> watchNetworkState() async {
    /// this for app initialization only
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network.
      hideGetXDialog();
    } else {
      showNoConnectionDialog();
    }

    /// this for listen in app
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('=====Called onConnectivityChanged');
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        // I am connected to a mobile network.
        hideGetXDialog();
      } else {
        showNoConnectionDialog();
      }
    });
  }

  hideGetXDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  showNoConnectionDialog({String? text}) {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    Get.dialog(
      const NoConnection(),
      barrierDismissible: false,
      useSafeArea: false,
    );
  }
}
