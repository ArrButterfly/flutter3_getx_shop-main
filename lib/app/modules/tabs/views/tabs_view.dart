/*
 * @Descripttion: 
 * @version: 
 * @Author: kiko
 * @Date: 2024-02-21 11:07:38
 * @LastEditors: kiko
 * @LastEditTime: 2024-02-22 15:11:39
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          extendBody: true,
          body: PageView(
            controller: controller.pageController,
            children: controller.pages,
            onPageChanged: (index) {
              controller.setCurrentIndex(index);
            },
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF), // 设置背景为白色
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(189, 146, 65, 0.10), // 阴影颜色
                  offset: Offset(0, -2), // 阴影偏移
                  blurRadius: 6.0, // 模糊半径
                  spreadRadius: 1.0, // 扩散半径
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                backgroundColor: const Color(0xFFFFFFFF), // 确保这里是白色
                fixedColor: const Color(0xFFF1871D), // 选中的颜色
                iconSize: 24, // 图标大小

                currentIndex: controller.currentIndex.value, // 当前选中的菜单
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  controller.setCurrentIndex(index);
                  controller.pageController.jumpToPage(index); // 页面转换
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage(
                            'assets/images/bottom_navigation_home_1.png'),
                        size: 24,
                      ),
                      // activeIcon: ImageIcon(
                      //   AssetImage(
                      //       'assets/images/bottom_navigation_home_2.png'), // 选中状态下的图标
                      //   size: 24,
                      // ),
                      label: "首页"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/shopping_bag.png'),
                        size: 24,
                      ),
                      label: "商城"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/planet_streamline.png'),
                        size: 24,
                      ),
                      label: "社区"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/chat_round.png'),
                        size: 24,
                      ),
                      label: "消息"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/me_pet_paw.png'),
                        size: 24,
                      ),
                      label: "Ta的"),
                ],
              ),
            ),
          ),
        ));
  }
}
