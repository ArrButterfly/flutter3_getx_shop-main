/*
 * @Descripttion: 
 * @version: 
 * @Author: kiko
 * @Date: 2024-02-21 10:54:07
 * @LastEditors: web-kiko kikoiiii@163.com
 * @LastEditTime: 2024-03-22 14:41:40
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../../units/keepAliveWrapper.dart'; //缓存状态
import '../../../units/screenAdapter.dart'; //适配
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; //瀑布流
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'dart:ui';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  //banner
  Widget _homeHeader() {
    return Obx(() => SizedBox(
          height: ScreenAdapter.height(358),
          width: double.infinity, // 使用全宽
          child: Stack(
            children: [
              //头像

              // 第一个径向渐变
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.6,
                    center: Alignment(0.352, 0.5779),
                    colors: [
                      Color.fromRGBO(248, 235, 190, 0.50),
                      Color.fromRGBO(248, 235, 190, 0.00),
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              // 第二个径向渐变
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.3,
                    center: Alignment(-0.527, -0.14),
                    colors: [
                      Color.fromRGBO(255, 211, 124, 0.40),
                      Color.fromRGBO(255, 211, 124, 0.00),
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              // 第三个径向渐变
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.7,
                    center: Alignment(0.547, -0.687),
                    colors: [
                      Color.fromRGBO(254, 158, 59, 0.80),
                      Color.fromRGBO(254, 158, 59, 0.00),
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              Center(
                  child: Column(
                children: [
                  SizedBox(height: ScreenAdapter.height(87)),
                  Container(
                      width: ScreenAdapter.width(343),
                      height: ScreenAdapter.height(145),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(children: [
                            //姓名、修改按钮
                            SizedBox(
                                height: ScreenAdapter.height(48),
                                child: Center(
                                  child: Row(
                                    children: [
                                      //宠物名字
                                      SizedBox(width: ScreenAdapter.width(97)),

                                      InkWell(
                                          onTap: () {
                                            controller.petNameArea();
                                          },
                                          child: Text(
                                            controller.isLogin.value
                                                ? (controller.userPetsModel
                                                        .isNotEmpty
                                                    ? controller
                                                        .userPetsModel[0]
                                                        .nickName
                                                        .toString()
                                                    : "添加我的宠物")
                                                : "未登录",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "PingFang SC",
                                              fontSize: 18,
                                            ),
                                          )),
                                      SizedBox(width: ScreenAdapter.width(7)),

                                      //修改宠物信息按钮
                                      controller.userPet.value
                                          ? InkWell(
                                              onTap: () {
                                                controller.petNameArea();
                                              },
                                              child: Container(
                                                width: ScreenAdapter.width(22),
                                                height:
                                                    ScreenAdapter.height(22),
                                                decoration:
                                                    const ShapeDecoration(
                                                  gradient: RadialGradient(
                                                    center:
                                                        Alignment(0.48, 0.76),
                                                    radius: 0,
                                                    colors: [
                                                      Color(0xFFFFD24E),
                                                      Color(0xFFFE9636)
                                                    ],
                                                  ),
                                                  shape: OvalBorder(
                                                    side: BorderSide(
                                                        width: 1,
                                                        color: Colors.white),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x33BE7F10),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 4),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    "assets/svg/modify_info.svg",
                                                  ),
                                                ),
                                              ))
                                          : const SizedBox.shrink(),

                                      const Spacer(),
                                      controller.userPetsModel.length > 1
                                          //拥有多个宠物
                                          ? InkWell(
                                              onTap: () {
                                                print("点击切换按钮");
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        ScreenAdapter.width(8)),
                                                child: Container(
                                                    width:
                                                        ScreenAdapter.width(65),
                                                    height:
                                                        ScreenAdapter.height(
                                                            32),
                                                    decoration: ShapeDecoration(
                                                      gradient:
                                                          const RadialGradient(
                                                        center: Alignment(
                                                            1.48, 0.46),
                                                        radius: 2,
                                                        colors: [
                                                          Color(0xFFFFD24E),
                                                          Color(0xFFFE9636)
                                                        ],
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x33BE7F10),
                                                          blurRadius: 4,
                                                          offset: Offset(0, 4),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Center(
                                                        child: Row(
                                                      children: [
                                                        SizedBox(
                                                            width: ScreenAdapter
                                                                .width(10)),
                                                        SvgPicture.asset(
                                                          "assets/svg/modify_switch.svg",
                                                        ),
                                                        SizedBox(
                                                            width: ScreenAdapter
                                                                .width(4)),
                                                        const Text("切换",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'PingFang SC')),
                                                      ],
                                                    ))),
                                              ))

                                          //低于2只宠物 无需切换按钮
                                          : const SizedBox.shrink(),
                                      //已登录
                                      controller.isLogin.value
                                          ? InkWell(
                                              onTap: () {
                                                //添加宠物按钮
                                                Get.toNamed("/add_pet_view");
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        ScreenAdapter.width(8)),
                                                child: Container(
                                                    width:
                                                        ScreenAdapter.width(32),
                                                    height:
                                                        ScreenAdapter.height(
                                                            32),
                                                    decoration: ShapeDecoration(
                                                      gradient:
                                                          const RadialGradient(
                                                        center: Alignment(
                                                            0.48, 0.76),
                                                        radius: 0,
                                                        colors: [
                                                          Color(0xFFFFD24E),
                                                          Color(0xFFFE9636)
                                                        ],
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    17.50),
                                                      ),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x33BE7F10),
                                                          blurRadius: 4,
                                                          offset: Offset(0, 4),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        "assets/svg/modify_add.svg",
                                                      ),
                                                    )),
                                              ))
                                          //未登录
                                          : InkWell(
                                              onTap: () {
                                                //点击跳转至登录页面
                                                Get.toNamed(
                                                    "/code-login-step-one");
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        ScreenAdapter.width(8)),
                                                child: Container(
                                                    width:
                                                        ScreenAdapter.width(65),
                                                    height:
                                                        ScreenAdapter.height(
                                                            32),
                                                    decoration: ShapeDecoration(
                                                      gradient:
                                                          const RadialGradient(
                                                        center: Alignment(
                                                            1.48, 0.46),
                                                        radius: 2,
                                                        colors: [
                                                          Color(0xFFFFD24E),
                                                          Color(0xFFFE9636)
                                                        ],
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x33BE7F10),
                                                          blurRadius: 4,
                                                          offset: Offset(0, 4),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Center(
                                                        child: Row(
                                                      children: [
                                                        SizedBox(
                                                            width: ScreenAdapter
                                                                .width(10)),
                                                        SvgPicture.asset(
                                                          "assets/svg/modify_add.svg",
                                                        ),
                                                        SizedBox(
                                                            width: ScreenAdapter
                                                                .width(4)),
                                                        const Text("添加",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'PingFang SC')),
                                                      ],
                                                    ))),
                                              ))
                                    ],
                                  ),
                                )),
                            SizedBox(height: ScreenAdapter.height(8)),
                            //宠物信息标签组

                            SizedBox(
                                height: ScreenAdapter.height(20),
                                child: Center(
                                    child: controller.isLogin.value
                                        ? (controller.userPet.value
                                            //拥有宠物
                                            ? Row(
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          ScreenAdapter.width(
                                                              16)),

                                                  // ignore: invalid_use_of_protected_member
                                                  controller
                                                              .userPetsModel
                                                              .value[0]
                                                              .gender ==
                                                          1
                                                      ?
                                                      //宠物性别男
                                                      Container(
                                                          width: ScreenAdapter
                                                              .width(18),
                                                          height: ScreenAdapter
                                                              .height(18),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 3,
                                                                  vertical: 2),
                                                          decoration:
                                                              ShapeDecoration(
                                                            color: const Color(
                                                                0x993B5DF5),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                            "assets/svg/modify_tag_group.svg",
                                                          )),
                                                        ) //宠物性别女
                                                      : Container(
                                                          width: ScreenAdapter
                                                              .width(18),
                                                          height: ScreenAdapter
                                                              .height(18),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 3,
                                                                  vertical: 2),
                                                          decoration:
                                                              ShapeDecoration(
                                                            color: const Color(
                                                                0x99F53B67),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                            "assets/svg/modify_tag_group_0.svg",
                                                          )),
                                                        ),
                                                  SizedBox(
                                                      width:
                                                          ScreenAdapter.width(
                                                              4)),

                                                  //宠物品种
                                                  Container(
                                                    width:
                                                        ScreenAdapter.width(66),
                                                    height:
                                                        ScreenAdapter.height(
                                                            18),
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0x33623FE2),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      '法国斗牛犬',
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.800000011920929),
                                                        fontSize: 10,
                                                        fontFamily:
                                                            'PingFang SC',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    )),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          ScreenAdapter.width(
                                                              4)),
                                                  //宠物绝育状态
                                                  Container(
                                                    width:
                                                        ScreenAdapter.width(46),
                                                    height:
                                                        ScreenAdapter.height(
                                                            18),
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0x33E2AC3F),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      controller
                                                                  .userPetsModel
                                                                  .value[0]
                                                                  .sterilized ==
                                                              0
                                                          ? '未绝育'
                                                          : '已绝育',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFFF9E26),
                                                        fontSize: 10,
                                                        fontFamily:
                                                            'PingFang SC',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    )),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          ScreenAdapter.width(
                                                              4)),
                                                  //宠物岁数
                                                  Container(
                                                    width:
                                                        ScreenAdapter.width(35),
                                                    height:
                                                        ScreenAdapter.height(
                                                            18),
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFFF6F6F6),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          controller.calculateAge(
                                                              controller
                                                                  .userPetsModel[
                                                                      0]
                                                                  .birthday
                                                                  .toString()),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'PingFang SC',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        const Text(
                                                          '岁',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 9,
                                                            fontFamily:
                                                                'PingFang SC',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          ScreenAdapter.width(
                                                              4)),
                                                  //宠物体重
                                                  Container(
                                                    width:
                                                        ScreenAdapter.width(35),
                                                    height:
                                                        ScreenAdapter.height(
                                                            18),
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFFF6F6F6),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        //体重
                                                        Text(
                                                          controller
                                                              .userPetsModel[0]
                                                              .weight
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'PingFang SC',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        const Text(
                                                          'kg',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 9,
                                                            fontFamily:
                                                                'PingFang SC',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                //没有宠物信息
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Get.toNamed("/add_pet_view");
                                                },
                                                child: _notLogPetTag(),
                                              ))
                                        //未登录标签组
                                        : InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                  "/code-login-step-one");
                                            },
                                            child: _notLogPetTag(),
                                          ))),

                            SizedBox(height: ScreenAdapter.height(15)),
                            //宠物提醒

                            Container(
                              width: ScreenAdapter.width(311),
                              height: ScreenAdapter.height(40),
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(1.00, 0.00),
                                  end: Alignment(-1, 0),
                                  colors: [
                                    Color(0xFFF9F6ED),
                                    Color(0xFFFDE8E2)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: ScreenAdapter.width(56)),
                                  Center(
                                    child: Text(
                                      '忘了驱虫？点我设置提醒',
                                      style: TextStyle(
                                        color: Colors.black
                                            .withOpacity(0.800000011920929),
                                        fontSize: 12,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: ScreenAdapter.width(89)),
                                  Container(
                                    width: ScreenAdapter.width(22),
                                    height: ScreenAdapter.height(22),
                                    decoration: const ShapeDecoration(
                                      gradient: RadialGradient(
                                        center: Alignment(0.48, 0.76),
                                        radius: 0,
                                        colors: [
                                          Color(0xFFFFD24E),
                                          Color(0xFFFE9636)
                                        ],
                                      ),
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1, color: Colors.white),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x33BE7F10),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center, // 垂直居中
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center, // 水平居中
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/modify_bell_1.svg",
                                        ),
                                        SvgPicture.asset(
                                          "assets/svg/modify_bell_2.svg",
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                          //日历
                          Positioned(
                              bottom: ScreenAdapter.height(20),
                              left: ScreenAdapter.width(25),
                              child: Container(
                                width: ScreenAdapter.width(41),
                                height: ScreenAdapter.height(43),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/home_calendar.png'),
                                  ),
                                ),
                              ))
                        ],
                      )),
                  //顶部主题栏
                  SizedBox(height: ScreenAdapter.height(5)),
                  _homeHeaderSwiper(),
                ],
              )),

              //宠物头像
              Positioned(
                  top: ScreenAdapter.height(60),
                  left: ScreenAdapter.height(31),
                  child: Container(
                    width: ScreenAdapter.width(72),
                    height: ScreenAdapter.height(72),
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        // image: NetworkImage("https://via.placeholder.com/72x72"),
                        image: AssetImage('assets/images/home_page_avatar.png'),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  )),
            ],

            // 主内容区域
          ),
        ));
  }

//功能
  Widget _bestSelling() {
    const String text1 = "宠物健康";
    const String text2 = "科学喂养";

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            ScreenAdapter.width(16), // 左侧边距
            ScreenAdapter.height(2), // 上边距
            ScreenAdapter.width(16), // 右侧边距
            ScreenAdapter.height(11), // 底部边距
          ),
          child: Row(
            children: [
              // 左侧
              Expanded(
                flex: 1,
                child: Container(
                  height: ScreenAdapter.height(220),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF98DAFB), Color(0xFFD8F0FB)],
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF98DAFB), // 边框颜色
                      ),
                      borderRadius: BorderRadius.circular(20), // 圆角半径
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed("/ai_chat_view");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 设置为左对齐
                      children: [
                        SizedBox(height: ScreenAdapter.height(14)),
                        const Padding(
                          padding: EdgeInsets.only(left: 14), // 设置左侧边距为 14
                          child: Text(
                            'AI 问诊',
                            style: TextStyle(
                              color: Color(0xFF242633),
                              fontSize: 17,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                              height: 1, // 设置合适的行高
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenAdapter.height(2)),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 14), // 设置左侧边距为 14
                          child: Text(
                            '记录日常并监测',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 10,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 1, // 设置合适的行高
                            ),
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: ScreenAdapter.height(160),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: ScreenAdapter.width(25),
                                  top: ScreenAdapter.height(2),
                                  child: Image.asset(
                                    'assets/images/consultation_icon_1.png',
                                    width: ScreenAdapter.width(133), // 设置宽度
                                    height: ScreenAdapter.height(80), // 设置高度
                                    fit: BoxFit.cover, // 填充方式
                                  ),
                                ),
                                Positioned(
                                    left: ScreenAdapter.width(118),
                                    top: ScreenAdapter.height(101),
                                    child: Image.asset(
                                      'assets/images/consultation_icon_6.png',
                                      width: ScreenAdapter.width(37.5), // 设置宽度
                                      height: ScreenAdapter.height(33), // 设置高度
                                      fit: BoxFit.cover, // 填充方式
                                    )),
                                Positioned(
                                    left: ScreenAdapter.width(47),
                                    top: ScreenAdapter.height(30),
                                    child: Image.asset(
                                      'assets/images/consultation_icon_2.png',
                                      width: ScreenAdapter.width(88), // 设置宽度
                                      height:
                                          ScreenAdapter.height(106.1), // 设置高度
                                      fit: BoxFit.cover, // 填充方式
                                    )),
                                Positioned(
                                    left: ScreenAdapter.width(69.43),
                                    top: ScreenAdapter.height(107),
                                    child: Image.asset(
                                      'assets/images/consultation_icon_3.png',
                                      width: ScreenAdapter.width(43.86), // 设置宽度
                                      height: ScreenAdapter.height(32), // 设置高度
                                      fit: BoxFit.cover, // 填充方式
                                    )),
                                Positioned(
                                    left: ScreenAdapter.width(81),
                                    top: ScreenAdapter.height(110),
                                    child: Image.asset(
                                      'assets/images/consultation_icon_4.png',
                                      width: ScreenAdapter.width(20), // 设置宽度
                                      height: ScreenAdapter.height(20), // 设置高度
                                      fit: BoxFit.cover, // 填充方式
                                    )),

                                Positioned(
                                    right: ScreenAdapter.width(62),
                                    bottom: ScreenAdapter.height(28),
                                    child: Image.asset(
                                      'assets/images/modify_consultation_icon_5.png',
                                      width: ScreenAdapter.width(20), // 设置宽度
                                      height: ScreenAdapter.height(20), // 设置高度
                                      fit: BoxFit.cover, // 填充方式
                                    )),
                                //盾牌下边阴影效果
                                Positioned(
                                  left: ScreenAdapter.width(124),
                                  top: ScreenAdapter.height(140),
                                  child: Container(
                                    width: ScreenAdapter.width(20),
                                    height: ScreenAdapter.height(6),
                                    decoration: ShapeDecoration(
                                      gradient: RadialGradient(
                                        center: const Alignment(0, 0),
                                        radius: 2.11,
                                        colors: [
                                          const Color(0xFFA27CFA)
                                              .withOpacity(0.25), // 设置透明度为 40%
                                          const Color(0xFFA27CFB)
                                              .withOpacity(0.0), // 完全透明
                                        ],
                                      ),
                                      shape: const OvalBorder(),
                                    ),
                                  ),
                                ),
                                //机器人下边阴影效果
                                Positioned(
                                  left: ScreenAdapter.width(70),
                                  top: ScreenAdapter.height(144),
                                  child: ClipOval(
                                    child: Container(
                                      width: ScreenAdapter.width(42), // 设置宽度
                                      height: ScreenAdapter.height(8), // 设置高度
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(
                                            162, 124, 251, 0.08), // 设置填充颜色
                                      ),
                                      // 使用 BackdropFilter 来实现模糊效果
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 2.0, sigmaY: 2.0), // 设置模糊效果
                                        child: Container(
                                          color: Colors.transparent, // 保持容器透明
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: ScreenAdapter.width(11)), // 右侧间距
              // 右侧
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: ScreenAdapter.height(220),
                  child: Column(
                    children: [
                      // 第一个盒子
                      SizedBox(
                        child: Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () {
                                //判断是否有宠物信息
                                controller.userPet.value
                                    ? Get.toNamed("/daily_records_view")
                                    : Get.defaultDialog(
                                        backgroundColor:
                                            const Color(0x00A1A1A1),
                                        title: "",
                                        titlePadding: const EdgeInsets.all(0),
                                        contentPadding: const EdgeInsets.all(0),
                                        content: _addPetTips());
                              },
                              child: _toPage(
                                  text1,
                                  const Color(0xFFF3E6FF),
                                  const Color(0xFFEAE6FF),
                                  const Color(0xFFE4DDFF))),
                        ),
                      ),

                      SizedBox(height: ScreenAdapter.height(12)), // 添加边距
                      // 第二个盒子
                      SizedBox(
                        width: ScreenAdapter.width(166),
                        height: ScreenAdapter.height(104),
                        child: Expanded(
                          flex: 1,
                          child: _scientificFeeding(
                            text2,
                            const Color(0x99FFEFCF),
                            const Color(0x99FFF5DF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //添加宠物弹窗提示
  Widget _addPetTips() {
    return Container(
      width: 235,
      height: 172,
      decoration: ShapeDecoration(
        color: Color(0xFFA1A1A1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '添加宠物',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            '添加宠物后才能为自己的宠物\n记录日常哦',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
              onTap: () {
                controller.addPetTips();
              },
              child: Container(
                  width: 104,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '立即添加',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  //宠物健康
  Widget _toPage(
      String pageText, Color startColor, Color finishColor, Color borderColor) {
    return Container(
      width: ScreenAdapter.width(166),
      height: ScreenAdapter.height(104),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, // 根据设计调整方向
          end: Alignment.bottomCenter,
          colors: [startColor, finishColor], // 渐变背景
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor), // 边框颜色
          borderRadius: BorderRadius.circular(20), // 确保与设计一致
        ),
      ),
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(0)), // 设置底部边距
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 14.0), // 左侧和上侧边距
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
                children: [
                  Text(
                    pageText,
                    style: const TextStyle(
                      color: Color(0xFF43234A),
                      fontSize: 17,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(2),
                  ),
                  Text(
                    '记录日常并监测',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  )
                ],
              )),
          Positioned(
              top: ScreenAdapter.height(30),
              left: ScreenAdapter.width(70.49),
              child: Image.asset(
                'assets/images/daily_records_curve_2.png',
                width: ScreenAdapter.width(94.3), // 设置宽度
                height: ScreenAdapter.height(30.5), // 设置高度
                fit: BoxFit.cover, // 填充方式
              )),
          Positioned(
              bottom: ScreenAdapter.height(9),
              right: ScreenAdapter.width(17.9),
              child: Image.asset(
                'assets/images/daily_records_2.png',
                width: ScreenAdapter.width(47.7), // 设置宽度
                height: ScreenAdapter.height(7.2), // 设置高度
                fit: BoxFit.cover, // 填充方式
              )),
          Positioned(
              top: ScreenAdapter.height(11),
              left: ScreenAdapter.width(95),
              child: Image.asset(
                'assets/images/daily_records_1.png',
                width: ScreenAdapter.width(77), // 设置宽度
                height: ScreenAdapter.height(85), // 设置高度
                fit: BoxFit.cover, // 填充方式
              ))
        ],
      ),
    );
  }

  //科学喂养
  Widget _scientificFeeding(
      String pageText, Color startColor, Color finishColor) {
    return Container(
        width: ScreenAdapter.width(166),
        height: ScreenAdapter.height(104),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // 根据设计调整方向
            end: Alignment.bottomCenter,
            colors: [startColor, finishColor], // 渐变背景
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFFFEFCF), // 边框颜色
            ),
            borderRadius: BorderRadius.circular(20), // 圆角半径
          ),
        ),
        margin: EdgeInsets.only(bottom: ScreenAdapter.height(0)), // 设置底部边距
        child: Stack(
          children: [
            Padding(
                padding:
                    const EdgeInsets.only(left: 14.0, top: 14.0), // 左侧和上侧边距
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
                  children: [
                    Text(
                      pageText,
                      style: const TextStyle(
                        color: Color(0xFF43234A),
                        fontSize: 17,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      height: ScreenAdapter.height(2),
                    ),
                    Text(
                      '精准分析宠物症状',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 10,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )
                  ],
                )),
            Positioned(
                bottom: ScreenAdapter.height(4),
                right: ScreenAdapter.width(5),
                child: Opacity(
                    opacity: 0.4,
                    child: SvgPicture.asset(
                      "assets/svg/scientific_health_2.svg",
                    ))),
            Positioned(
                top: ScreenAdapter.height(23),
                right: ScreenAdapter.width(4.5),
                child: Image.asset(
                  'assets/images/scientific_health_1.png',
                  width: ScreenAdapter.width(67), // 设置宽度
                  height: ScreenAdapter.height(67), // 设置高度
                  fit: BoxFit.cover, // 填充方式
                )),
            Positioned(
                bottom: ScreenAdapter.height(34.69),
                right: ScreenAdapter.width(4.5),
                child: Image.asset(
                  'assets/images/scientific_health_3.png',
                  width: ScreenAdapter.width(24), // 设置宽度
                  height: ScreenAdapter.height(30), // 设置高度
                  fit: BoxFit.cover, // 填充方式
                )),
            Positioned(
                top: ScreenAdapter.height(85),
                right: ScreenAdapter.width(32),
                child: Opacity(
                    opacity: 0.5,
                    child: SvgPicture.asset(
                      "assets/svg/scientific_health_6.svg",
                    ))),
            Positioned(
                top: ScreenAdapter.height(62),
                right: ScreenAdapter.width(34),
                child: Image.asset(
                  'assets/images/scientific_health_4.png',
                  width: ScreenAdapter.width(45), // 设置宽度
                  height: ScreenAdapter.height(45), // 设置高度
                  fit: BoxFit.cover, // 填充方式
                )),
            Positioned(
                bottom: ScreenAdapter.height(18),
                left: ScreenAdapter.width(68),
                child: Image.asset(
                  'assets/images/scientific_health_7.png',
                  width: ScreenAdapter.width(22), // 设置宽度
                  height: ScreenAdapter.height(6), // 设置高度
                  fit: BoxFit.cover, // 填充方式
                )),
            Positioned(
                bottom: ScreenAdapter.height(17.85),
                left: ScreenAdapter.width(67),
                child: Image.asset(
                  'assets/images/scientific_health_5.png',
                  width: ScreenAdapter.width(18.63), // 设置宽度
                  height: ScreenAdapter.height(21.96), // 设置高度
                  fit: BoxFit.cover, // 填充方式
                ))
          ],
        ));
  }

  Widget _homeHeaderSwiper() {
    return SizedBox(
      height: ScreenAdapter.height(110),
      width: double.infinity,
      child: Stack(
        children: [
          // Swiper 组件
          Center(
            // 使用 Center 使其居中
            child: SizedBox(
              height: ScreenAdapter.height(100), // Swiper 的高度
              width: ScreenAdapter.width(343), // 设定 Swiper 的宽度
              child: Swiper(
                itemCount: controller.homeImages.length,
                autoplay: true, // 启用自动滑动
                autoplayDelay: 3000, // 设置自动滑动的时间为 3 秒
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        print("进入公益活动——————————>");
                        Get.toNamed(Routes.ACTIVITY_CENTER_VIEW);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(controller.homeImages[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ));
                },
                onIndexChanged: (index) {
                  controller.currentIndex.value = index; // 更新当前索引
                },
              ),
            ),
          ),
          // 指示灯
          Positioned(
            bottom: ScreenAdapter.height(12), // 距离底部 8 像素
            left: 0,
            right: 0, // 使指示灯居中
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(controller.homeImages.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentIndex.value == index
                        ? 18
                        : 8, // 根据状态设置宽度
                    height: ScreenAdapter.height(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: controller.currentIndex.value == index
                          ? Colors.white // 选中状态的背景色
                          : Colors.white.withOpacity(0.6), // 未选中状态的背景色
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }

  //Ai盒子
  Widget _bestSellingAi() {
    const String text1 = "宠物训练";
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(16), 0, ScreenAdapter.width(16), 0),
          child: Row(
            children: [
              //左侧
              Expanded(
                  flex: 1,
                  child: Container(
                      height: ScreenAdapter.height(104),
                      width: ScreenAdapter.width(166),
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.93, -0.36), // 角度 111度 对应的起始点
                          end: Alignment(-0.93, 0.36), // 角度 111度 对应的结束点
                          colors: [
                            Color(0xFFFFF0F1), // #FFE3E3
                            Color(0xFFFFE3E3), // #FFF0F1
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFFFE3E3)), // 边框颜色
                          borderRadius: BorderRadius.circular(20), // 圆角半径
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 14.0, top: 14.0), // 左侧和上侧边距
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start, // 左对齐
                                children: [
                                  const Text(
                                    '在线咨询',
                                    style: TextStyle(
                                      color: Color(0xFF512B2B),
                                      fontSize: 17,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenAdapter.height(2),
                                  ),
                                  Text(
                                    '专业医生为您解答',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 10,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )
                                ],
                              )),

                          //阴影
                          Positioned(
                              bottom: ScreenAdapter.height(8),
                              right: ScreenAdapter.width(14),
                              child: Image.asset(
                                'assets/images/online_consultation_1.png',
                                width: ScreenAdapter.width(46), // 设置宽度
                                height: ScreenAdapter.height(8), // 设置高度
                                fit: BoxFit.cover, // 填充方式
                              )),

                          //图标
                          Positioned(
                              top: ScreenAdapter.height(17),
                              left: ScreenAdapter.width(87),
                              child: Image.asset(
                                'assets/images/online_consultation.png',
                                width: ScreenAdapter.width(83), // 设置宽度
                                height: ScreenAdapter.height(82), // 设置高度
                                fit: BoxFit.cover, // 填充方式
                              )),
                        ],
                      ))),
              SizedBox(width: ScreenAdapter.width(11)),
              //右侧
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: ScreenAdapter.height(104),
                  child: Column(
                    children: [
                      // 训练课程
                      Expanded(
                          flex: 1,
                          child: Container(
                              height: ScreenAdapter.height(104),
                              width: ScreenAdapter.width(166),
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(0.0, -1.0), // 180度方向
                                  end: Alignment(0, 1),
                                  colors: [
                                    Color(
                                        0x60CCF4A5), // rgba(204, 244, 165, 0.30)
                                    Color(
                                        0x60ECFFC6), // rgba(236, 255, 198, 0.30)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0x99CCF4A5), // 边框颜色
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(20), // 圆角半径
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14.0, top: 14.0), // 左侧和上侧边距
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start, // 左对齐
                                        children: [
                                          const Text(
                                            '训练课程',
                                            style: TextStyle(
                                              color: Color(0xFF2B3722),
                                              fontSize: 17,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenAdapter.height(2),
                                          ),
                                          Text(
                                            '克服应激第一课',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 10,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          )
                                        ],
                                      )),

                                  //阴影
                                  Positioned(
                                      bottom: ScreenAdapter.height(12),
                                      right: ScreenAdapter.width(2),
                                      child: Image.asset(
                                        'assets/images/training_courses_2.png',
                                        width: ScreenAdapter.width(71), // 设置宽度
                                        height:
                                            ScreenAdapter.height(12), // 设置高度
                                        fit: BoxFit.cover, // 填充方式
                                      )),

                                  //图标
                                  Positioned(
                                      top: ScreenAdapter.height(17),
                                      left: ScreenAdapter.width(87),
                                      child: Image.asset(
                                        'assets/images/training_courses.png',
                                        width: ScreenAdapter.width(81), // 设置宽度
                                        height:
                                            ScreenAdapter.height(81), // 设置高度
                                        fit: BoxFit.cover, // 填充方式
                                      )),

                                  //网球阴影
                                  Positioned(
                                      bottom: ScreenAdapter.height(16),
                                      right: ScreenAdapter.width(69.8),
                                      child: Image.asset(
                                        'assets/images/training_courses_3.png',
                                        width: ScreenAdapter.width(11), // 设置宽度
                                        height: ScreenAdapter.height(3), // 设置高度
                                        fit: BoxFit.cover, // 填充方式
                                      )),
                                  //网球
                                  Positioned(
                                      bottom: ScreenAdapter.height(17),
                                      right: ScreenAdapter.width(67),
                                      child: Image.asset(
                                        'assets/images/training_courses_1.png',
                                        width:
                                            ScreenAdapter.width(17.1), // 设置宽度
                                        height:
                                            ScreenAdapter.height(17.1), // 设置高度
                                        fit: BoxFit.cover, // 填充方式
                                      )),
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  //未登录宠物品种信息

  Widget _notLogPetTag() {
    return Row(
      children: [
        SizedBox(width: ScreenAdapter.width(16)),
        //宠物品种
        Container(
          width: ScreenAdapter.width(56),
          height: ScreenAdapter.height(18),
          decoration: ShapeDecoration(
            color: const Color(0x33623FE2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Center(
              child: Text(
            '补充品种',
            style: TextStyle(
              color: Colors.black.withOpacity(0.800000011920929),
              fontSize: 10,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          )),
        ),
        SizedBox(width: ScreenAdapter.width(4)),
        //宠物绝育状态
        Container(
          width: ScreenAdapter.width(76),
          height: ScreenAdapter.height(18),
          decoration: ShapeDecoration(
            color: const Color(0x33E2AC3F),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Center(
              child: Text(
            '补充绝育状态',
            style: TextStyle(
              color: Color(0xFFFF9E26),
              fontSize: 10,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          )),
        ),
      ],
      //未登录标签组
    );
  }

  //内容区域
  Widget _homePage() {
    return Column(
      children: [
        SizedBox(height: ScreenAdapter.height(350)),
        _bestSelling(),
        _bestSellingAi(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFAF6),
        body: Stack(
          children: [
            _homeHeader(),
            _homePage(),
          ],
        ),
      ),
    );
  }
}
