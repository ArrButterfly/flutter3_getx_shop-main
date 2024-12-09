import 'package:get/get.dart';

import '../controllers/record_calendar_controller.dart';

class RecordCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordCalendarController>(
      () => RecordCalendarController(),
    );
  }
}
