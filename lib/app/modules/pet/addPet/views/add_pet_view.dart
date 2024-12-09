/*
 * @ Author: lee
 * @ Create Time: 2024-03-04 11:57:43
 * @ Modified by: lee
 * @ Modified time: 2024-04-02 22:46:32
 * @ Description:
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_pet_controller.dart';
import '../../../../widget/passTextField.dart';
import '../../../../widget/PassButton.dart';

class AddPetView extends GetView<AddPetController> {
  const AddPetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFf5f4ee), // 设置整体页面背景颜色
      appBar: AppBar(
        title: const Text("添加宠物"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20), // 顶部距离为20
          Center(
            child: SizedBox(
              width: 136,
              height: 136,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFd9d9d9), // 背景色为灰色
                  shape: BoxShape.circle, // 形状为圆形
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      // 在这里添加按钮点击事件
                      print("添加图片");
                    },
                    icon: const Icon(Icons.image),
                    iconSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //输入
                PassTextFiled(
                    controller: controller.telController,
                    hintText: "我叫",
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      print(value);
                    }),
                const SizedBox(height: 10),
                PassTextFiled(
                    // controller: controller.passController,
                    hintText: "我是",
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      print(value);
                    }),
                PassButton(
                  text: "下一步",
                  onPressed: () async {
                    if (controller.telController.text.isEmpty) {
                      Get.snackbar("提示信息", "请输入昵称");
                    } else {
                      //添加到实体类
                      controller.addPetName();
                      Get.toNamed("/choose_pet_info_view");
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
