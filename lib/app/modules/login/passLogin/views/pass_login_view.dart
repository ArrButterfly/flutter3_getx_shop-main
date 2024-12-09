import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/pass_login_controller.dart';

import '../../../../models/message_mmw.dart';
import '../../../../units/screenAdapter.dart';
import '../../../../widget/logo.dart';
import '../../../../widget/passButton.dart';
import '../../../../widget/passTextField.dart';
import '../../../../widget/userAgreement.dart';

class PassLoginView extends GetView<PassLoginController> {
  const PassLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [TextButton(onPressed: () {}, child: Text("帮助"))],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        children: [
          const Logo(),
          //输入手机号
          PassTextFiled(
              controller: controller.telController,
              hintText: "请输入账号",
              onChanged: (value) {
                print(value);
              }),

          PassTextFiled(
              controller: controller.passController,
              hintText: "请输入密码",
              onChanged: (value) {
                print(value);
              }),

          //登录按钮
          PassButton(
              text: "登录",
              onPressed: () async {
                // print("获取验证码");
                if (controller.telController.text.length <= 1) {
                  Get.snackbar("提示信息!", "账号有误！");
                } else if (controller.passController.text.length < 3) {
                  Get.snackbar("提示信息!", "密码长度不能小于3位");
                } else {
                  MessageMmwModel result = await controller.doLogin();
                  if (result.code == 200) {
                    //执行跳转  回到根
                    // Get.offAllNamed("/tabs",arguments: {
                    //   "initialPage":4   //注册完成后会加载tabs第五个页面
                    // });
                    Get.back();
                  } else {
                    Get.snackbar("提示信息!", result.message);
                  }
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: const Text("忘记密码")),
              TextButton(onPressed: () {}, child: const Text("验证码登录"))
            ],
          ),
          const SizedBox(height: 30),
          //用户协议
          const UserAgreement(),
        ],
      ),
    );
  }
}
