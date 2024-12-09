// ignore_for_file: non_constant_identifier_names

/*
 * @ Author: lee
 * @ Create Time: 2024-12-03 11:57:43
 * @ Modified by: lee
 * @ Description:
 */

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/app/models/user_mmw_model.dart';
import '../controllers/daily_records_controller.dart';

class DailyRecordsView extends GetView<DailyRecordsController> {
  const DailyRecordsView({Key? key}) : super(key: key);

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
                          color: const Color(0xFFD9D9D9),
                          shape: BoxShape.circle, // 设置为圆形
                          border: Border.all(
                              width: 2, color: const Color(0xFFD9D9D9)), // 设置边框
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
                      color: const Color(0xFFD9D9D9),
                      shape: BoxShape.circle, // 设置为圆形
                      border: Border.all(
                          width: 2, color: const Color(0xFFD9D9D9)), // 设置边框
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

  //记录列表
  Widget _recordList(String recordName, String state, bool controlButtons,
      int type, Widget stateValue, Widget stateValueExpand) {
    return Center(
        child: Container(
      width: 345,
      padding: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(children: [
        //状态
        SizedBox(
          height: 80,
          width: double.infinity,
          child: Column(children: [
            Row(
              children: [
                Text(
                  recordName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 5),
                //展开按钮
                !controlButtons
                    ? InkWell(
                        onTap: () {
                          controller.expandView(type);
                        },
                        child: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                      )
                    : const SizedBox.shrink(),

                const Spacer(),
                InkWell(
                    onTap: () {
                      controller.petHealthUpload(recordName);
                    },
                    child: Container(
                        width: 68,
                        height: 28,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFA1A1A1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '记录',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )))
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  state, //萎靡
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 5),
                //提示
                // const Icon(
                //   Icons.error,
                //   size: 14,
                //   color: Colors.grey,
                // )
              ],
            ),
            const SizedBox(height: 5),
            stateValue,
          ]),
        ),

        //展开后
        controlButtons ? stateValueExpand : const SizedBox.shrink()
      ]),
    ));
  }

  Widget _statusBlock(String name, int type) {
    // 判断当前状态是否与 recordsData['spiritStatus'] 相同
    Color backgroundColor = const Color(0xFFF5F5F5);
    if (type == 1) {
      backgroundColor = controller.recordsData['spiritStatus'] == name
          ? const Color(0xFFA1A1A1) // 如果匹配，使用这个颜色
          : const Color(0xFFF5F5F5); // 否则使用默认颜色
    }
    if (type == 2) {
      backgroundColor = controller.recordsData['spiritPlayTime'] == name
          ? const Color(0xFFA1A1A1) // 如果匹配，使用这个颜色
          : const Color(0xFFF5F5F5); // 否则使用默认颜色
    }
    if (type == 3) {
      backgroundColor = controller.recordsData['spiritSleepTime'] == name
          ? const Color(0xFFA1A1A1) // 如果匹配，使用这个颜色
          : const Color(0xFFF5F5F5); // 否则使用默认颜色
    }
    if (type == 7) {
      backgroundColor = controller.recordsData['foodAmount'] == name
          ? const Color(0xFFA1A1A1) // 如果匹配，使用这个颜色
          : const Color(0xFFF5F5F5); // 否则使用默认颜色
    }
    if (type == 8) {
      backgroundColor = controller.recordsData['foodType'] == name
          ? const Color(0xFFA1A1A1) // 如果匹配，使用这个颜色
          : const Color(0xFFF5F5F5); // 否则使用默认颜色
    }

    return InkWell(
        onTap: () {
          controller.statusBlockClick(name, type);
        },
        child: Container(
            height: 21,
            padding: const EdgeInsets.symmetric(horizontal: 4), // 设置左右内边距为 4
            decoration: ShapeDecoration(
              color: backgroundColor, // 使用动态背景颜色
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
            child: Center(
                child: Opacity(
              opacity: 0.60,
              child: Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ))));
  }

  //状态展开
  Widget _mentalStateExpand(
      String StateName,
      String StateTwoName,
      bool controlButtons,
      int type,
      Widget StateValuExpand,
      Widget StateValuExpandTwo) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Opacity(
          opacity: 0.10,
          child: Container(
            width: 315,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              StateName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            const Spacer(),
            //展开按钮
            controlButtons
                ? InkWell(
                    onTap: () {
                      controller.expandView(type);
                    },
                    child: const Icon(
                      Icons.arrow_drop_up,
                      color: Colors.grey,
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
        const SizedBox(height: 5),
        //状态展开
        StateValuExpand,
        const SizedBox(height: 10),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StateTwoName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        //状态展开2
        StateValuExpandTwo
      ],
    );
  }

  //精神状态值
  Widget _mentalStateValue() {
    return Row(
      children: [
        _statusBlock("萎靡", 1),
        const SizedBox(width: 6),
        _statusBlock("消极", 1),
        const SizedBox(width: 6),
        _statusBlock("正常", 1),
        const SizedBox(width: 6),
        _statusBlock("活跃", 1),
        const SizedBox(width: 6),
        _statusBlock("兴奋", 1),
      ],
    );
  }

  //精神状态展开1
  Widget _mentalStateValueExpand() {
    return Row(
      children: [
        _statusBlock("< 30min", 2),
        const SizedBox(width: 6),
        _statusBlock("30min ~ 1h", 2),
        const SizedBox(width: 6),
        _statusBlock("1h ~ 2h", 2),
        const SizedBox(width: 6),
        _statusBlock("2h ~ 4h", 2),
        const SizedBox(width: 6),
        _statusBlock("> 4h", 2),
      ],
    );
  }

  //精神状态展开2
  Widget _mentalStateValueExpandTwo() {
    return Row(
      children: [
        _statusBlock("< 8h", 3),
        const SizedBox(width: 6),
        _statusBlock("8h ~ 10h", 3),
        const SizedBox(width: 6),
        _statusBlock("10h ~ 16h", 3),
        const SizedBox(width: 6),
        _statusBlock("16h ~ 19h", 3),
        const SizedBox(width: 6),
        _statusBlock("> 19h", 3),
      ],
    );
  }

//社交互动状态值
  Widget _socialInteractionValue() {
    return Row(
      children: [
        _statusBlock("警惕警觉", 4),
        const SizedBox(width: 6),
        _statusBlock("爱答不理", 4),
        const SizedBox(width: 6),
        _statusBlock("正常", 4),
        const SizedBox(width: 6),
        _statusBlock("特别亲人", 4),
      ],
    );
  }

//社交互动状态值展开1
  Widget _socialInteractionExpand() {
    return Row(
      children: [
        _statusBlock("< 10min", 5),
        const SizedBox(width: 6),
        _statusBlock("10 ~ 20min", 5),
        const SizedBox(width: 6),
        _statusBlock("20 ~ 30min", 5),
        const SizedBox(width: 6),
        _statusBlock("> 30min", 5),
      ],
    );
  }

  //社交互动状态值展开2
  Widget _socialInteractionExpandTow() {
    return Column(
      children: [
        Row(
          children: [
            _statusBlock("惬意", 6),
            const SizedBox(width: 6),
            _statusBlock("放松", 6),
            const SizedBox(width: 6),
            _statusBlock("警觉", 6),
            const SizedBox(width: 6),
            _statusBlock("害怕", 6),
            const SizedBox(width: 6),
            _statusBlock("惊恐", 6),
          ],
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: 0.10,
          child: Container(
            width: 315,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerLeft,
          child: Opacity(
            opacity: 0.60,
            child: Text(
              '建议：注意观察近日是否有令咪宝不安的因素出现',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        )
      ],
    );
  }

  //进食
  Widget _eatingStatusValue() {
    return Row(
      children: [
        _statusBlock("很少", 7),
        const SizedBox(width: 6),
        _statusBlock("较少", 7),
        const SizedBox(width: 6),
        _statusBlock("正常", 7),
        const SizedBox(width: 6),
        _statusBlock("较多", 7),
        const SizedBox(width: 6),
        _statusBlock("很多", 7),
      ],
    );
  }

  //进食展开2
  Widget _eatingStatusExpand() {
    return Row(
      children: [
        _statusBlock("干粮", 8),
        const SizedBox(width: 6),
        _statusBlock("罐头", 8),
      ],
    );
  }

  Widget _eatingStatusExpandTow() {
    return Row(
      children: [
        _inputBox(1),
        const SizedBox(width: 6),
        const Opacity(
          opacity: 0.60,
          child: Text(
            'g',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  //饮水量
  Widget _waterIntake() {
    return Row(
      children: [
        _inputBox(2),
        const SizedBox(width: 6),
        const Opacity(
          opacity: 0.60,
          child: Text(
            'ml',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _waterIntakeTow() {
    return Column(
      children: [
        Opacity(
          opacity: 0.10,
          child: Container(
            width: 315,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(
          width: 315,
          child: Opacity(
            opacity: 0.60,
            child: Text(
              '建议：5公斤的猫咪每天需要喝约220-330毫升的水‌，咪宝目前饮水量远低于需求量，有泌尿系统疾病、肾病等风险，注意督促咪宝多喝水哦。',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        )
      ],
    );
  }

//排泄状态值
  Widget _excretionStatusValue() {
    return Row(
      children: [
        _statusBlock("未排泄", 9),
        const SizedBox(width: 6),
        _statusBlock("量少", 9),
        const SizedBox(width: 6),
        _statusBlock("正常", 9),
        const SizedBox(width: 6),
        _statusBlock("较多", 9),
        const SizedBox(width: 6),
        _statusBlock("腥臭", 9),
      ],
    );
  }

  //排泄状态值
  Widget _excretionStatusValueTow() {
    return Column(
      children: [
        Row(
          children: [
            _statusBlock("排便", 10),
            const SizedBox(width: 6),
            _statusBlock("排尿", 10),
          ],
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '排便形态',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        Row(
          children: [
            _statusBlock("水状", 11),
            const SizedBox(width: 6),
            _statusBlock("稀状", 11),
            const SizedBox(width: 6),
            _statusBlock("泥状", 11),
            const SizedBox(width: 6),
            _statusBlock("软圆条状", 11),
            const SizedBox(width: 6),
            _statusBlock("圆柱状", 11),
            const SizedBox(width: 6),
            _statusBlock("节状", 11),
            const SizedBox(width: 6),
            _statusBlock("球状", 11),
          ],
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '排便气味',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        Row(
          children: [
            _statusBlock("无异味", 12),
            const SizedBox(width: 6),
            _statusBlock("臭", 12),
            const SizedBox(width: 6),
            _statusBlock("腥臭", 12),
          ],
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '排便分量',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        Row(
          children: [
            _statusBlock("比平时少", 13),
            const SizedBox(width: 6),
            _statusBlock("跟平时差不多", 13),
            const SizedBox(width: 6),
            _statusBlock("比平时多", 13),
          ],
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: 0.10,
          child: Container(
            width: 315,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '排尿情况',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        Row(
          children: [
            _statusBlock("清澈透亮", 14),
            const SizedBox(width: 6),
            _statusBlock("云雾状", 14),
            const SizedBox(width: 6),
            _statusBlock("絮状", 14),
          ],
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '排尿气味',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        Row(
          children: [
            _statusBlock("无异味", 15),
            const SizedBox(width: 6),
            _statusBlock("轻微刺激性", 15),
            const SizedBox(width: 6),
            _statusBlock("苹果味", 15),
            const SizedBox(width: 6),
            _statusBlock("腐败腥臭味", 15),
          ],
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '尿团大小',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        Row(
          children: [
            _statusBlock("水滴", 16),
            const SizedBox(width: 6),
            _statusBlock("棒棒糖", 16),
            const SizedBox(width: 6),
            _statusBlock("乒乓球", 16),
            const SizedBox(width: 6),
            _statusBlock("高尔夫球", 16),
            const SizedBox(width: 6),
            _statusBlock("桌球", 16),
          ],
        ),
      ],
    );
  }

  //体重状态值
  Widget _weightStatusValue() {
    return Row(
      children: [
        _statusBlock("轻了", 17),
        const SizedBox(width: 6),
        _statusBlock("差不多", 17),
        const SizedBox(width: 6),
        _statusBlock("重了", 17),
      ],
    );
  }

  //体重状态值展开
  Widget _weightStatusValueExpand() {
    return Column(
      children: [
        Row(
          children: [
            _inputBox(3),
            const SizedBox(width: 6),
            const Opacity(
              opacity: 0.60,
              child: Text(
                'kg',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '体型',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        Row(
          children: [
            _statusBlock("瘦弱", 18),
            const SizedBox(width: 6),
            _statusBlock("偏瘦", 18),
            const SizedBox(width: 6),
            _statusBlock("匀称", 18),
            const SizedBox(width: 6),
            _statusBlock("偏胖", 18),
            const SizedBox(width: 6),
            _statusBlock("肥胖", 18),
          ],
        ),
        const SizedBox(height: 7),
        const SizedBox(
          width: 315,
          child: Opacity(
            opacity: 0.60,
            child: Text(
              '看：能清楚看到肋骨、腰椎和髋骨；侧面腹部提收、极度凹陷；从头部到尾部有明显。\n摸：尾巴根部、脊椎和肋骨上摸不到脂肪；能直接摸到肋骨、腰椎和髋骨。',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '肌群',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )),
        const SizedBox(height: 5),
        Row(
          children: [
            _statusBlock("重度流失", 19),
            const SizedBox(width: 6),
            _statusBlock("中度流失", 19),
            const SizedBox(width: 6),
            _statusBlock("轻度流失", 19),
            const SizedBox(width: 6),
            _statusBlock("正常肌群", 19),
          ],
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: 0.10,
          child: Container(
            width: 315,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
            alignment: Alignment.centerLeft,
            child: Opacity(
              opacity: 0.60,
              child: Text(
                '建议：咪宝体型瘦弱，适当增加体重有利于咪宝健康',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            )),
      ],
    );
  }

  //输入框
  Widget _inputBox(int type) {
    return InkWell(
      onTap: () {
        // 弹出弹窗
        Get.defaultDialog(
          title: "输入值",
          content: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "请输入",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // 处理输入内容
                  controller.eatTodayData['foodAmount'] = value;
                  controller.recordsData['foodAmount'] = value;
                },
              ),
            ],
          ),
          confirm: ElevatedButton(
            onPressed: () {
              // 处理确认逻辑
              controller.clickInputBox(type);
              Get.back(); // 关闭弹窗
            },
            child: const Text("确认"),
          ),
          cancel: ElevatedButton(
            onPressed: () {
              Get.back(); // 关闭弹窗
            },
            child: const Text("取消"),
          ),
        );
      },
      child: Container(
        width: 42,
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: ShapeDecoration(
          color: const Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Center(
            child: Text(controller.recordsData['foodAmount']
                .toString())), // 可选：在输入框上添加提示文本
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: const Color(0xFFF5F5F5), // 设置整体页面背景颜色
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
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
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed("/record_calendar_view");
              },
              child: const Icon(
                Icons.calendar_month,
                color: Colors.black,
                size: 20,
              ),
            ),
            const SizedBox(width: 15)
          ],
          title: const Center(
              child: Text(
            '日常记录',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 17,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          )),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0), // 设置你希望的高度
              child: _switchPets(controller.userPetsModel.value)),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 15),
                    _recordList(
                        "精神状态",
                        "根据您的记录，咪宝今日的精神状态应为",
                        controller.mentalState.value,
                        1,
                        _mentalStateValue(),
                        _mentalStateExpand(
                            "今日走动、跑动、玩耍时长",
                            "今日睡眠时长",
                            controller.mentalState.value,
                            1,
                            _mentalStateValueExpand(),
                            _mentalStateValueExpandTwo())),
                    const SizedBox(height: 15),
                    _recordList(
                        "社交互动",
                        "根据您的记录，咪宝今日的互动状态为",
                        controller.socialInteraction.value,
                        2,
                        _socialInteractionValue(),
                        _mentalStateExpand(
                            "今日互动时长",
                            "今日互动状态",
                            controller.socialInteraction.value,
                            2,
                            _socialInteractionExpand(),
                            _socialInteractionExpandTow())),
                    const SizedBox(height: 15),
                    _recordList(
                        "今日进食",
                        "根据您的记录，咪宝今日进食",
                        controller.eatToday.value,
                        3,
                        _eatingStatusValue(),
                        _mentalStateExpand(
                            "食物类型，可多选",
                            "进食量",
                            controller.eatToday.value,
                            3,
                            _eatingStatusExpand(),
                            _eatingStatusExpandTow())),
                    const SizedBox(height: 15),
                    _recordList(
                        "今日饮水",
                        "根据您的记录，咪宝今日饮水",
                        controller.drinkWaterToday.value,
                        4,
                        _eatingStatusValue(),
                        _mentalStateExpand(
                            "饮水量",
                            "",
                            controller.drinkWaterToday.value,
                            4,
                            _waterIntake(),
                            _waterIntakeTow())),
                    const SizedBox(height: 15),
                    _recordList(
                        "今日排泄",
                        "根据您的记录，推测咪宝的精神状态为",
                        controller.excretionToday.value,
                        5,
                        _excretionStatusValue(),
                        _mentalStateExpand(
                            "排泄类型",
                            "",
                            controller.excretionToday.value,
                            5,
                            _excretionStatusValueTow(),
                            const SizedBox.shrink())),
                    const SizedBox(height: 15),
                    _recordList(
                        "今日体重",
                        "根据您的记录，咪宝体重增加超10%",
                        controller.todayWeight.value,
                        6,
                        _weightStatusValue(),
                        _mentalStateExpand(
                            "体重",
                            "",
                            controller.todayWeight.value,
                            6,
                            _weightStatusValueExpand(),
                            const SizedBox.shrink())),
                  ],
                ),
              ],
            ),
            controller.oneClickRecordButton.value
                ? Positioned(
                    bottom: 40, // 距离底部 40 像素
                    left: 15,
                    child: Container(
                        width: 345,
                        height: 44,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Center(
                          child: Text(
                            '一键记录',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 17,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )),
                  )
                : const SizedBox.shrink(),
          ],
        )));
  }
}
