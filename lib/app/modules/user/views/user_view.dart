/*
 * @ Author: kiko
 * @ Create Time: 2024-03-04 11:57:43
 * @ Modified by: kiko
 * @ Modified time: 2024-04-02 22:46:32
 * @ Description:
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiko_getx_xmshop/app/models/user_mmw_model.dart';
import '../../../units/screenAdapter.dart';
import '../controllers/user_controller.dart';

//宠物盒子
Widget _petBox(UserController controller) {
  return Center(
    child: Container(
      width: 335, // 设置宽度
      height: 255, // 设置高度
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // 圆角
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFFFF), // 渐变起始颜色
            Color(0xFFFFF5D3), // 渐变结束颜色
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFFD858),
            blurRadius: 4, // 模糊半径
            offset: Offset(0, 2), // 阴影偏移
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 25.5), // 设置左边距为20
                child: Image.asset(
                  "assets/images/default_avatar.png",
                  fit: BoxFit.cover, // 保持原比例
                  height: 80, // 设置图片的高度
                  width: 80, // 设置图片的宽度
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 25.5), // 给整个 Column 左边距
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 确保文本左对齐
                  children: [
                    Obx(
                      () => controller.isLogin.value
                          ? InkWell(
                              onTap: () {
                                if (controller.userPetsModel.isEmpty) {
                                  Get.toNamed("/add_pet_view");
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "${controller.userPetsModel.isNotEmpty ? controller.userPetsModel[0].nickName : "添加我的宠物"}",
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    controller.userPetsModel[0].gender == 0
                                        ? Icons.female
                                        : Icons.male,
                                  )
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Get.toNamed("/code-login-step-one");
                              },
                              child: const Text(
                                "添加我的宠物",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(height: 4), // 添加一些间距
                    Text(
                      "品种：${controller.userPetsModel[0].breedId} | 年龄：${controller.userPetsModel.isNotEmpty ? controller.calculateAge(controller.userPetsModel[0].birthday.toString()) : '待补充'}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA2510E),
                      ),
                    ),
                    Text(
                      "体重：${controller.userPetsModel[0].weight}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA2510E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 中间对齐
            children: [
              Container(
                width: 140,
                height: 61,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Colors.white, Color(0xFFFFF4D3)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0xFFFFD858),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.60,
                          child: Container(
                            width: 16,
                            height: 16,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Icon(
                              Icons.calendar_month_outlined,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Opacity(
                          opacity: 0.50,
                          child: Text(
                            '距离1岁生日还有',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        children: [
                          Text(
                            '${controller.userPetsModel.isNotEmpty ? controller.daysUntilNextBirthday(controller.userPetsModel[0].birthday.toString()) : '待补充'}',
                            style: const TextStyle(
                              color: Color(0xFFA2510E),
                              fontSize: 17,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          const Text(
                            '天',
                            style: TextStyle(
                              color: Color(0xFFA2510E),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Container(
                width: 140,
                height: 61,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Colors.white, Color(0xFFFFF4D3)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0xFFFFD858),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.60,
                          child: Container(
                            width: 16,
                            height: 16,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Icon(
                              Icons.alarm,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Opacity(
                          opacity: 0.50,
                          child: Text(
                            '我们一起生活了',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        children: [
                          Text(
                            '${controller.userPetsModel.isNotEmpty ? controller.daysSinceArrivedDay(controller.userPetsModel[0].arrivedDay.toString()) : '待补充'}',
                            style: const TextStyle(
                              color: Color(0xFFA2510E),
                              fontSize: 17,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          const Text(
                            '天',
                            style: TextStyle(
                              color: Color(0xFFA2510E),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 295,
              height: 44,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.71, 0.71),
                  end: Alignment(0.71, -0.71),
                  colors: [Color(0xFFFFE97D), Color(0xFFFFB960)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '邀请家人',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 17,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

//切换宠物
Widget _switchPets(List<UserPetsModel> userPetsModel) {
  return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 200, // 设置最大宽度为200
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // 设置为左右居中
              children: [
                const SizedBox(height: 59),
                ...userPetsModel.map((pet) => Container(
                      width: 60,
                      height: 66,
                      margin: const EdgeInsets.only(right: 10), // 仅设置右边距为10
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E0),
                        shape: BoxShape.circle, // 设置为圆形
                        border: Border.all(
                            width: 2, color: const Color(0xFFFFF8E0)), // 设置边框
                      ),
                      child: Center(
                        child: Text(
                          pet.nickName.toString(),
                          style: const TextStyle(fontSize: 10),
                        ), // 显示宠物的昵称
                      ),
                    )),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E0),
                    shape: BoxShape.circle, // 设置为圆形
                    border: Border.all(
                        width: 2, color: const Color(0xFFFFF8E0)), // 设置边框
                  ),
                  child: Center(
                    // 确保图标在容器中心
                    child: InkWell(
                      onTap: () {
                        Get.toNamed("/add_pet_view");
                      },
                      child: const Icon(
                        Icons.add, // 使用添加图标
                        color: Colors.black, // 图标颜色
                        size: 24, // 图标大小
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )));
}

//我的记录
Widget _myRecord(String recordName) {
  return Container(
      width: 335,
      height: 70,
      margin: const EdgeInsets.only(top: 15), // 设置左边距为20，上边距为15
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Center(
        child: Text(
          recordName,
          style: const TextStyle(
            fontSize: 17,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w600,
          ),
        ),
      ));
}

//未登录
Widget _noPets(UserController controller) {
  return Column(
    children: [
      const SizedBox(height: 85),
      // 盒子
      Center(
        child: Container(
          width: 335, // 设置宽度
          height: 120, // 设置高度
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // 圆角
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF), // 渐变起始颜色
                Color(0xFFFFF5D3), // 渐变结束颜色
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFFFD858),
                blurRadius: 4, // 模糊半径
                offset: Offset(0, 2), // 阴影偏移
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // 确保 Row 只占用必要的宽度
            mainAxisAlignment: MainAxisAlignment.start, // 左对齐
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20), // 设置左边距为20
                child: Image.asset(
                  "assets/images/default_avatar.png",
                  fit: BoxFit.cover, // 保持原比例
                  height: 80, // 设置图片的高度
                  width: 80, // 设置图片的宽度
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 25.5), // 给整个 Column 左边距
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 确保文本左对齐
                  children: [
                    Obx(
                      () => controller.isLogin.value
                          ? InkWell(
                              onTap: () {
                                if (controller.userPetsModel.isEmpty) {
                                  Get.toNamed("/add_pet_view");
                                }
                              },
                              child: const Text(
                                "添加我的宠物",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Get.toNamed("/code-login-step-one");
                              },
                              child: const Text(
                                "添加我的宠物",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(height: 4), // 添加一些间距
                    const Text(
                      "品种：待补充 | 年龄：待补充",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA2510E),
                      ),
                    ),
                    const Text(
                      "体重：待补充",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA2510E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f4ee), // 设置整体页面背景颜色
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.height(0)),
        children: [
          Obx(
            () => Container(
              width: 375,
              height: controller.userPet.value ? 410 : 210,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFFFFDD6D), Color(0x00FFDD6D)],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
              ),
              child: Stack(
                // 使用Stack来叠加盒子和图片
                children: [
                  // 右下角的图片
                  Align(
                    alignment: Alignment.topRight, // 设置为右上角
                    child: SizedBox(
                      width: 160, // 设置宽度
                      height: 163.48, // 设置高度
                      child: Image.asset(
                        "assets/images/background_cat.png", // 替换为你需要的图片
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Obx(() => controller.userPet.value
                      ? Column(
                          //已登录
                          children: [
                            const SizedBox(height: 60),
                            _switchPets(controller.userPetsModel.value),
                            const SizedBox(height: 10),
                            _petBox(controller),
                          ],
                        )
                      : _noPets(controller)), //未登录
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 设置为左右居中
            children: [
              Container(
                width: 160,
                height: 103,
                decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-0.71, 0.71),
                      end: Alignment(-0.91, -0.71),
                      colors: [Color(0xFFFF7459), Color(0xFFFFC6BB)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 让Column只占用必要的高度
                    children: [
                      Text(
                        "喵喵币余额",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                width: 160,
                height: 103,
                decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-0.91, 0.21),
                      end: Alignment(0.91, -0.91),
                      colors: [Color(0xFFFFE97D), Color(0xFFFFB960)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 让Column只占用必要的高度
                    children: [
                      Text(
                        "我的会员",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "2024-2025",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              _myRecord("日常任务"),
              _myRecord("发帖记录"),
              _myRecord("咨询任务"),
              _myRecord("购物记录"),
              const SizedBox(height: 120)
            ],
          )
        ],
      ),
    );
  }
}
