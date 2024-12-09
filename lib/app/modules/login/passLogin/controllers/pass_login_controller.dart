import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/message_mmw.dart';
import '../../../../units/httpsMmwClient.dart';
import '../../../../units/storage.dart';
import '../../../user/controllers/user_controller.dart';

class PassLoginController extends GetxController {
  TextEditingController telController = TextEditingController();
  TextEditingController passController = TextEditingController();
  HttpsMmwClient httpsClient = HttpsMmwClient();
  UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // 更新用户状态
    print("更新用户状态");
    userController.getUserInfo();
    super.onClose();
  }

  Future<MessageMmwModel> doLogin() async {
    try {
      var response = await httpsClient.post("api/account/user/appLogin", data: {
        "userName": telController.text,
        "password": passController.text,
      });

      print(response);
      if (response != null && response.statusCode == 200) {
        // 使用 response.data 访问内容
        if (response.data['code'] == 200) {
          print("开始保存用户信息");
          // 假设用户信息在 data 字段中，您可以将其转换为 List
          var userInfo = response.data["data"]; // 获取用户信息

          // 将用户信息转换为 List
          List<dynamic> userInfoList = [userInfo]; // 将 Map 包装成 List

          // 保存用户信息
          await Storage.setData("userinfo", userInfoList); // 保存为 List 类型
          return MessageMmwModel(message: "登录成功", code: 200);
        }
        return MessageMmwModel(message: response.data["message"], code: 500);
      } else {
        return MessageMmwModel(message: "网络异常", code: 502);
      }
    } catch (e) {
      print("请求异常: $e");
      return MessageMmwModel(message: "请求异常", code: 502);
    }
  }
}
