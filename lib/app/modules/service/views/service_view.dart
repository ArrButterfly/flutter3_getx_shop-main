/*
 * @ Author: kiko
 * @ Create Time: 2024-04-21 20:51:55
 * @ Modified by: kiko
 * @ Modified time: 2024-04-22 03:53:29
 * @ Description:
 */

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_controller.dart';
import '../jiPush/views/ji_push_view.dart';
import '../lanya/views/lanya_view.dart';
import '../live/views/live_view.dart';
import '../watch/views/watch_view.dart';
import '../wift/views/wift_view.dart';
import '../oneClickLogin/views/one_click_login_view.dart';

class ServiceView extends GetView<ServiceController> {
  ServiceView({Key? key}) : super(key: key);
  List<Map<String, IconData>> blocks = [
    {
      '消息1': Icons.person,
    },
    {
      '消息2': Icons.person,
    },
    {
      '消息3': Icons.person,
    },
    {
      '消息4': Icons.person,
    },
    {
      '消息5': Icons.person,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: blocks.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 2.0,
                color: Color.fromARGB(255, 201, 198, 198),
              ),
              bottom: BorderSide(
                width: 2.0,
                color: Color.fromARGB(255, 201, 198, 198),
              ),
            ),
          ),
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(), //解决滑动
              shrinkWrap: true,
              itemBuilder: (context, itemIndex) {
                return InkWell(
                  onTap: () {
                    _handClickItem(blocks[index].keys.elementAt(itemIndex));
                  },
                  child: ListTile(
                    leading: Icon(blocks[index].values.elementAt(itemIndex)),
                    title: Text(blocks[index].keys.elementAt(itemIndex)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
              separatorBuilder: (context, itemIndex) {
                return const Divider();
              },
              itemCount: blocks[index].length),
        );
      },
    );
  }
}

_handClickItem(String itemTitle) {
  switch (itemTitle) {
    case "极光推送":
      Get.to(const JiPushView());
      print("激光通讯");
      break;
    case "实时聊天":
      Get.to(const WatchView());
      break;
    case "娱乐直播":
      Get.to(const LiveView());
      break;
    case "蓝牙通讯":
      Get.to(const LanyaView());
      break;
    case "wift":
      Get.to(const WiftView());
      break;
    case "一键登录":
      Get.to(const OneClickLoginView());

      break;
  }
}
