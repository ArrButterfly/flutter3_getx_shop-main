import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../models/message.dart';
import '../../../../units/screenAdapter.dart';
import '../../../../widget/logo.dart';
import '../../../../widget/passButton.dart';
import '../../../../widget/passTextField.dart';
import '../../../../widget/userAgreement.dart';
import '../controllers/code_login_step_one_controller.dart';

class CodeLoginStepOneView extends GetView<CodeLoginStepOneController> {
  const CodeLoginStepOneView({Key? key}) : super(key: key);
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
        padding: EdgeInsets.all(30),
        children: [
          //logo
          const Logo(),
          //输入手机号
          PassTextFiled(
              controller: controller.telController,
              hintText: "请输入手机号",
              onChanged: (value) {
                print(value);
              }),

          //登录按钮
          Container(
            margin: EdgeInsets.only(top: 40),
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFFFDD6D)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)))),
              onPressed: () async {
                if (!GetUtils.isPhoneNumber(controller.telController.text) ||
                    controller.telController.text.length != 11) {
                  Get.snackbar("提示信息!", "手机号格式不合法");
                } else {
                  MessageModel result = await controller.sendCode();
                  if (result.success) {
                    //替换路由
                    Get.offAndToNamed("/code-login-step-two",
                        arguments: {"tel": controller.telController.text});
                  } else {
                    Get.snackbar("提示信息!", result.message);
                  }
                }
              },
              child: Text(
                "获取验证码",
                style: TextStyle(fontSize: 26),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF07C160)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70)))),
              onPressed: () {},
              child: Text(
                "微信登录",
                style: TextStyle(fontSize: 26),
              ),
            ),
          ),
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Get.toNamed("/register-step-one");
                  },
                  child: const Text("新用户注册")),
              TextButton(
                  onPressed: () {
                    // Get.toNamed("/pass-login");
                    //替换路由
                    Get.offAndToNamed("/pass-login");
                  },
                  child: const Text("账户密码登录"))
            ],
          ),
          const SizedBox(height: 180),
          //用户协议
          const UserAgreement(),
        ],
      ),
    );
  }
}
