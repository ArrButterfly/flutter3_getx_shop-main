import 'package:get/get.dart';

import '../controllers/daily_records_controller.dart';

class DailyRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyRecordsController>(
      () => DailyRecordsController(),
    );
  }
}
