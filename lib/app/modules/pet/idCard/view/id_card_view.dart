/*
 * @ Author: lee
 * @ Create Time: 2024-03-04 11:57:43
 * @ Modified by: lee
 * @ Modified time: 2024-04-02 22:46:32
 * @ Description:
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/id_card_controller.dart';
import '../../../../widget/passTextField.dart';
import '../../../../widget/PassButton.dart';
import '../../../../models/user_mmw_model.dart';

class IdCardView extends StatelessWidget {
  const IdCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 注册 Controller
    final IdCardController controller = Get.put(IdCardController());
    return Scaffold(
        // backgroundColor: const Color(0xFFf5f4ee), // 设置整体页面背景颜色
        appBar: AppBar(
          title: const Text("身份卡"),
        ),
        body: Column(
          children: [
            Container(
                height: 510,
                child: Obx(() {
                  return ListView(
                    children:
                        List.generate(controller.userPetsModel.length, (index) {
                      return idCard(controller.userPetsModel[index]);
                    }),
                  );
                })),
            PassButton(
              text: "      确定      ",
              onPressed: () async {
                //执行跳转  回到根
                Get.offAllNamed("/tabs", arguments: {
                  "initialPage": 4 //注册完成后会加载tabs第五个页面
                });
              },
            ),
            PassButton(
              text: "      下载到相册      ",
              onPressed: () async {
                // 处理完成按钮逻辑

                //下一步
                Get.toNamed("/info_display_view");
              },
            )
          ],
        ));
  }

  Widget idCard(UserPetsModel pet) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            width: 335,
            height: 200,
            padding: const EdgeInsets.all(20),
            decoration: ShapeDecoration(
              color: Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0, // 确保位置在可视区域内
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Opacity(
                                          opacity: 0.50,
                                          child: Text(
                                            '姓名',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 9),
                                        Text(
                                          "${pet.nickName}", //昵称
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 40),
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Opacity(
                                          opacity: 0.50,
                                          child: Text(
                                            '性别',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 9),
                                        Text(
                                          "${pet.gender == 0 ? '男' : '女'}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: 0.50,
                            child: Text(
                              '品种',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(width: 9),
                          Text(
                            '中华田园猫 重点色',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Opacity(
                            opacity: 0.50,
                            child: Text(
                              '出生',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Text(
                            "${pet.birthday ?? ' '}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Opacity(
                            opacity: 0.50,
                            child: Text(
                              '身份ID',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Text(
                            '${pet.id}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
