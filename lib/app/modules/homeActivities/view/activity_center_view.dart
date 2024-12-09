/*
 * @ Author: lee
 * @ Create Time: 2024-03-04 11:57:43
 */

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../units/screenAdapter.dart';
import '../controllers/activities_controller.dart';

//我的记录
Widget _myRecord(Map<String, dynamic> task) {
  return Container(
    width: 335,
    height: 70,
    margin: const EdgeInsets.only(top: 15), // 设置上边距
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: Row(
      children: [
        const SizedBox(width: 15),
        Text(
          task['nameStr'], // 从任务对象中获取任务名称
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 20),
        Text("${task['status'][2]}/${task['status'][1]}",
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 10,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            )),
        const Spacer(),
        Text(
          "${task['rewardNum']}g", // 从任务对象中获取奖励数量
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            // 领取奖励的逻辑
            // 这里可以使用 task['userId'] 等信息
            Get.snackbar("领取奖励", "您领取了 ${task['rewardNum']}g 猫粮");
          },
          // ignore: unrelated_type_equality_checks
          child: Text(task['status'][0].toString() == -1
              ? '领取'
              // ignore: unrelated_type_equality_checks
              : (task['status'][0].toString() == 1)
                  ? '已领取'
                  : '去做任务'),
        ),
        const SizedBox(width: 15),
      ],
    ),
  );
}

// 进度条
Widget _buildProgressBar(ActivitiesController controller) {
  return Container(
    width: 162,
    height: 22,
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: ShapeDecoration(
            color: Color(0xFFA1A1A1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            '${controller.totalTaskData.value['level'].toString()}级',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 5),
        Text(
          controller.totalTaskData.value['upgradePercentage'].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 5),
        Text(
          '${controller.totalTaskData.value['expenseToUpgrade'].toString()}/${controller.totalTaskData.value['nextLevelExpense'].toString()}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        Container(
          width: 31,
          height: 31,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/activity_center_donate_cat.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}

// 捐赠猫粮按钮
Widget _buildDonateButton(
    BuildContext context, ActivitiesController controller) {
  return InkWell(
    onTap: () {
      print("点击捐赠按钮");
      controller.donate();
    },
    child: Container(
      width: 120,
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              '捐赠200g',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "猫粮: ${controller.score.value}",
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 10,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}

//触发猫粮动画效果
Widget _animationEffects() {
  return Positioned(
    right: 170, // 根据需求调整位置
    top: 129, // 根据需求调整位置
    child: Column(
      children: [
        Container(
          width: 50, // 小圆圈的直径
          height: 50, // 小圆圈的直径
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text("+200g"),
          ),
        ),
      ],
    ),
  );
}

class ActivityCenterView extends GetView<ActivitiesController> {
  const ActivityCenterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9), // 设置整体页面背景颜色
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF9F9F9),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.black,
            ),
          ),
          title: const Text(
            '活动中心',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 17,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
        body: Obx(
          () => ListView(
            padding: EdgeInsets.all(ScreenAdapter.height(0)),
            children: [
              SizedBox(
                height: 368,
                child: Stack(
                  children: [
                    Positioned(
                      left: 28, // 根据需求调整位置
                      top: 21, // 根据需求调整位置
                      child: InkWell(
                        onTap: () {
                          //点击抽奖
                          print("--------->>");
                          controller.lottery();
                          Get.defaultDialog(
                            backgroundColor: const Color(0xFFA1A1A1),
                            title: "",
                            content: Container(
                              width: 300,
                              height: 206,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFA1A1A1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Center(
                                      child: SizedBox(
                                    width: 68,
                                    child: Text(
                                      '恭喜中奖',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  )),
                                  const SizedBox(height: 10),
                                  const SizedBox(
                                    width: 260,
                                    child: Text(
                                      '抽到猫粮',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Obx(() {
                                    return SizedBox(
                                      width: 260,
                                      child: Text(
                                        controller.scoreUpdate.value.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 64,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      //关闭弹窗
                                      Get.back();
                                      Get.snackbar("提示信息!", "重置抽奖次数成功");
                                    },
                                    child: Container(
                                        width: 104,
                                        height: 36,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '收下猫粮',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 14,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            //关闭
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 50, // 小圆圈的直径
                              height: 50, // 小圆圈的直径
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text("? g"),
                              ),
                            ),
                            const SizedBox(height: 5), // 圆圈和文本之间的间距
                            const Text(
                              "点我抽奖",
                              style: TextStyle(
                                color: Colors.black, // 文本颜色
                                fontSize: 12, // 文本大小
                              ),
                            ),
                            const Text(
                              "20g猫粮/次",
                              style: TextStyle(
                                color: Colors.black, // 文本颜色
                                fontSize: 12, // 文本大小
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16, // 根据需求调整位置
                      top: 109, // 根据需求调整位置
                      child: Column(
                        children: [
                          Container(
                            width: 50, // 小圆圈的直径
                            height: 50, // 小圆圈的直径
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text("10g"),
                            ),
                          ),
                          const SizedBox(height: 5), // 圆圈和文本之间的间距
                          const Text(
                            "猫粮/狗粮",
                            style: TextStyle(
                              color: Colors.black, // 文本颜色
                              fontSize: 12, // 文本大小
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 31, // 根据需求调整位置
                      top: 287, // 根据需求调整位置
                      child: Column(
                        children: [
                          Container(
                            width: 50, // 小圆圈的直径
                            height: 50, // 小圆圈的直径
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text("10g"),
                            ),
                          ),
                          const SizedBox(height: 5), // 圆圈和文本之间的间距
                          const Text(
                            "猫粮/狗粮",
                            style: TextStyle(
                              color: Colors.black, // 文本颜色
                              fontSize: 12, // 文本大小
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 31, // 根据需求调整位置
                      top: 287, // 根据需求调整位置
                      child: Column(
                        children: [
                          Container(
                            width: 50, // 小圆圈的直径
                            height: 50, // 小圆圈的直径
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text("10g"),
                            ),
                          ),
                          const SizedBox(height: 5), // 圆圈和文本之间的间距
                          const Text(
                            "猫粮/狗粮",
                            style: TextStyle(
                              color: Colors.black, // 文本颜色
                              fontSize: 12, // 文本大小
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                        right: 0, // 根据需求调整位置
                        top: 10, // 根据需求调整位置
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    backgroundColor: const Color(0xFFA1A1A1),
                                    title: "",
                                    content: Container(
                                      width: 240,
                                      height: 300,
                                      padding: const EdgeInsets.only(top: 50),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFA1A1A1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 18,
                                            child: Text(
                                              '公益活动',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 50),
                                          InkWell(
                                            onTap: () {
                                              //公益活动
                                              Get.back();
                                              Get.toNamed("/donate-view");
                                            },
                                            child: Container(
                                                width: 104,
                                                height: 36,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    '前往签署',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFF333333),
                                                      fontSize: 14,
                                                      fontFamily: 'PingFang SC',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    //关闭
                                  );
                                },
                                child: Container(
                                  width: 96, // 小圆圈的直径
                                  height: 36, // 小圆圈的直径
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFA1A1A1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18), // 左上角曲线
                                      bottomLeft: Radius.circular(18), // 左下角曲线
                                      // 右边角保持直角，右上和右下不需要设置
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "公益活动",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Center(
                        child: Column(
                      children: [
                        const SizedBox(height: 54),
                        //cat img
                        Container(
                          width: 145,
                          height: 176,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/activity_center_cat.png'), // 使用 AssetImage
                              fit: BoxFit.cover, // 适应方式，可以根据需要选择
                            ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        // 进度条
                        _buildProgressBar(controller),
                        const SizedBox(height: 30),
                        // 捐赠猫粮按钮
                        _buildDonateButton(context, controller),
                        const SizedBox(height: 10),
                        Text(
                          "已捐献: ${controller.totalTaskData.value['currentLevelExpense'].toString()}猫粮",
                          style: const TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 10,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    )),
                    // 添加猫粮动画效果
                    controller.animationEffects.value
                        ? _animationEffects()
                        : const SizedBox.shrink()
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                      width: 335,
                      height: 113,
                      margin: const EdgeInsets.only(top: 15), // 设置左边距为20，上边距为15
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15), // 设置左边距和上边距
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // 确保内容左对齐
                          children: [
                            const Text(
                              "宠物健康记录",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8), // 可选：文本和下方内容之间的间距
                            Row(
                              children: [
                                ...List.generate(5, (index) {
                                  // 计算每日任务状态和相应值的索引
                                  int statusIndex = index; // 0-4 下标
                                  int valueIndex = index + 5; // 5-9 下标
                                  int dayIndex = index + 10; // 10-14 下标

                                  String statusText;
                                  switch (controller
                                      .dailyUploadTasksList[statusIndex]) {
                                    case -1:
                                      statusText = "可领取";
                                      break;
                                    case 1:
                                      statusText = "已领取";
                                      break;
                                    case 2:
                                      statusText = "未上传";
                                      break;
                                    default:
                                      statusText = "未上传"; // 默认状态
                                  }

                                  return Column(
                                    children: [
                                      Container(
                                        width: 36, // 小圆圈的直径
                                        height: 36, // 小圆圈的直径
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${controller.dailyUploadTasksList[valueIndex]}g", // 显示可领取的值
                                            style: const TextStyle(
                                                // 可根据需求设置文本样式
                                                ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "第${controller.dailyUploadTasksList[dayIndex]}天", // 显示第几天的值
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        statusText, // 显示状态
                                        style: const TextStyle(
                                          fontSize: 8,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  );
                                }).expand((widget) {
                                  return [
                                    widget,
                                    const SizedBox(width: 8.83), // 每个小圆圈之间的间隙
                                  ];
                                }).toList()
                                  ..removeLast(), // 最后一个元素后删除多余的 SizedBox

                                const SizedBox(width: 20),

                                // 添加按钮
                                Container(
                                  width: 68,
                                  height: 29,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            controller.rewardTextButton();
                                          },
                                          child: SizedBox(
                                            width: 48,
                                            child: Text(
                                              controller.dailyUploadTasksText(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color(0xFF333333),
                                                fontSize: 12,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                // 领取按钮
                              ],
                            )
                          ],
                        ),
                      )),

                  // 确保总任务数据不为空
                  controller.taskList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          width: 335,
                          // 使用 Container 包裹 ListView
                          child: ListView.builder(
                            shrinkWrap: true, // 设置为 true
                            physics:
                                const NeverScrollableScrollPhysics(), // 禁止 ListView 滚动
                            itemCount: controller.taskList.length,
                            itemBuilder: (context, index) {
                              var task = controller.taskList[index];
                              return _myRecord(task);
                            },
                          ),
                        ),

                  const SizedBox(height: 40),
                ],
              )
            ],
          ),
        ));
  }
}
