import 'package:get/get.dart';
import 'main_app_controller.dart';
import 'network_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MainAppController>(MainAppController(), permanent: true);
    Get.put<NetworkController>(NetworkController(), permanent: true);
    //  Get.put<ProfileController>(ProfileController(DioConsumer(dio: Dio())));
  }
}
