/*
 * @ Author: kiko
 * @ Create Time: 2024-03-21 02:39:33
 * @ Modified by: kiko
 * @ Modified time: 2024-03-29 03:23:53
 * @ Description:
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../views/cart_item_mun_view.dart';

import '../controllers/product_content_controller.dart';
import '../../../units/screenAdapter.dart';
import '../views/frist_tab_view.dart';
import '../views/two_tab_view.dart';
import '../views/three_tab_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({Key? key}) : super(key: key);

  //tab中商品 showBottomAttr多个嵌套渲染不出来的问题把他抽离了出来
  //action 1点击的是筛选属性   2 点击的是加入购物车   3 表示点击的是立即购买
  void showBottomAttr(int action) {
    Get.bottomSheet(
        //bottomSheet更新流数据obx（）不行，需要使用 GetBuilder 来渲染数据
        GetBuilder<ProductContentController>(
      init: controller,
      builder: (controller) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          width: double.infinity,
          height: ScreenAdapter.height(1200),
          child: Stack(
            children: [
              ListView(children: [
                ...controller.pcontent.value.attr!.map((v) {
                  return Wrap(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: ScreenAdapter.height(20),
                            left: ScreenAdapter.width(20)),
                        width: ScreenAdapter.width(1040),
                        child: Text("${v.cate}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: ScreenAdapter.height(20),
                            left: ScreenAdapter.width(20)),
                        width: ScreenAdapter.width(1040),
                        child: Wrap(
                            children: v.attrList!.map((value) {
                          return InkWell(
                            onTap: () {
                              controller.changeAttr(v.cate, value["title"]);
                            },
                            child: Container(
                              margin: EdgeInsets.all(ScreenAdapter.width(20)),
                              child: Chip(
                                  padding: EdgeInsets.only(
                                      left: ScreenAdapter.width(20),
                                      right: ScreenAdapter.width(20)),
                                  backgroundColor: value["checked"] == true
                                      ? Colors.red
                                      : const Color.fromARGB(31, 223, 213, 213),
                                  label: Text(value["title"])),
                            ),
                          );
                        }).toList()),
                      ),
                    ],
                  );
                }).toList(),
                //数量
                Padding(
                  padding: EdgeInsets.all(ScreenAdapter.height(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("数量",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      CartItemMunView(),
                    ],
                  ),
                )
              ]),
              Positioned(
                  right: 2,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  )),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: action == 1
                      ? Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: ScreenAdapter.height(120),
                                  margin: EdgeInsets.only(
                                      right: ScreenAdapter.width(20)),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromRGBO(
                                                    255, 165, 0, 0.9)),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            // CircleBorder()
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    onPressed: () {
                                      controller.addCart();
                                    },
                                    child: const Text("加入购物车"),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: ScreenAdapter.height(120),
                                  margin: EdgeInsets.only(
                                      right: ScreenAdapter.width(20)),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromRGBO(
                                                    253, 1, 0, 0.9)),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            // CircleBorder()
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    onPressed: () {
                                      controller.buy();
                                    },
                                    child: const Text("立即购买"),
                                  ),
                                ))
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: ScreenAdapter.height(120),
                                  margin: EdgeInsets.only(
                                      right: ScreenAdapter.width(20)),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromRGBO(
                                                    253, 1, 0, 0.9)),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            // CircleBorder()
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    onPressed: () {
                                      if (action == 2) {
                                        controller.addCart();
                                      } else {
                                        controller.buy();
                                      }
                                    },
                                    child: const Text("确定"),
                                  ),
                                ))
                          ],
                        ))
            ],
          ),
        );
      },
    ));
  }

  Widget _appBar(BuildContext context) {
    return Obx(
      () => AppBar(
        leading: Container(
          alignment: Alignment.center,
          child: SizedBox(
              width: ScreenAdapter.width(88),
              height: ScreenAdapter.width(88),
              //返回按钮
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                    //注意:去掉button默认的padding
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
              )),
        ),
        title: SizedBox(
          width: ScreenAdapter.width(400),
          height: ScreenAdapter.height(96),
          child: controller.showTabs.value
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.tabsList.map((v) {
                    return InkWell(
                        onTap: () {
                          controller.changeSelectedTabsIndex(v["id"]);
                          //跳转到指定的容器
                          if (v["id"] == 1) {
                            Scrollable.ensureVisible(
                                //结合下面的SingleChildScrollView实现锚点跳转
                                controller.gk1.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 100));
                          } else if (v["id"] == 2) {
                            Scrollable.ensureVisible(
                                controller.gk2.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 100));
                            //修正
                            Timer.periodic(const Duration(milliseconds: 101),
                                (timer) {
                              controller.scrollController.jumpTo(
                                  controller.scrollController.position.pixels -
                                      ScreenAdapter.height(120));
                              timer.cancel();
                            });
                          } else {
                            Scrollable.ensureVisible(
                                controller.gk3.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 100));
                            //修正
                            Timer.periodic(const Duration(milliseconds: 101),
                                (timer) {
                              controller.scrollController.jumpTo(
                                  controller.scrollController.position.pixels -
                                      ScreenAdapter.height(120));
                              timer.cancel();
                            });
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${v["title"]}",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(36)),
                            ),
                            v["id"] == controller.selectedTabsIndex.value
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenAdapter.height(10)),
                                    width: ScreenAdapter.width(100),
                                    height: ScreenAdapter.height(2),
                                    color: Colors.red,
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenAdapter.height(10)),
                                    width: ScreenAdapter.width(100),
                                    height: ScreenAdapter.height(2),
                                  )
                          ],
                        ));
                  }).toList())
              : const Text(""),
        ),
        centerTitle: true,
        backgroundColor:
            Colors.white.withOpacity(controller.opcity.value), //实现透明导航
        elevation: 0, //实现透明导航
        actions: [
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(88),
            height: ScreenAdapter.width(88),
            child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    //注意:去掉button默认的padding
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                child: const Icon(
                  Icons.file_upload_outlined,
                )),
          ),
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(88),
            height: ScreenAdapter.width(88),
            child: ElevatedButton(
                onPressed: () {
                  showMenu(
                      color: Colors.black87.withOpacity(0.7),
                      context: context,
                      position: RelativeRect.fromLTRB(
                          ScreenAdapter.width(800),
                          ScreenAdapter.height(220),
                          ScreenAdapter.width(20),
                          0),
                      items: [
                        const PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.home, color: Colors.white),
                              Text("首页", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.message, color: Colors.white),
                              Text("消息", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.white),
                              Text("收藏", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        )
                      ]);
                },
                style: ButtonStyle(
                    //注意
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                child: const Icon(
                  Icons.more_horiz_rounded,
                )),
          ),
        ],
      ),
    );
  }

//tab中详情
  Widget _subHeader() {
    return Obx(() => Container(
          color: Colors.white,
          child: Row(
              children: controller.subTabsList.map((value) {
            return Expanded(
                child: InkWell(
              onTap: () {
                controller.changeSelectedSubTabsIndex(value["id"]);
              },
              child: Container(
                height: ScreenAdapter.height(120),
                alignment: Alignment.center,
                child: Text("${value["title"]}",
                    style: TextStyle(
                        color: controller.selectedSubTabsIndex == value["id"]
                            ? Colors.red
                            : Colors.black87)),
              ),
            ));
          }).toList()),
        ));
  }

  Widget _body() {
    //singlechildScerollView锚点 controller.gk1.currentContext as BuildContext实现tab跳转
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          FristTabView(showBottomAttr),
          TwoTabView(_subHeader),
          ThreeTabView()
        ],
      ),
    );
  }

  //立即购买
  Widget _bottom() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: ScreenAdapter.height(160),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      width: ScreenAdapter.width(2), color: Colors.black12))),
          child: Row(
            children: [
              SizedBox(
                width: ScreenAdapter.width(200),
                height: ScreenAdapter.height(160),
                child: InkWell(
                  onTap: () {
                    Get.toNamed("/cart");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_cart),
                      Text(
                        "购物车",
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdapter.height(120),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(255, 165, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              // CircleBorder()
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        showBottomAttr(2);
                      },
                      child: const Text("加入购物车"),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdapter.height(120),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(253, 1, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              // CircleBorder()
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        showBottomAttr(3);
                      },
                      child: const Text("立即购买"),
                    ),
                  ))
            ],
          ),
        ));
  }

//内容区域
  Widget _contentImg() {
    return Container(
      width: 375,
      height: 340,
      child: _homeHeaderSwiper(),
    );
  }

  Widget _homeHeaderSwiper() {
    return SizedBox(
      height: 340,
      width: 375,
      child: Stack(
        children: [
          // Swiper 组件
          Center(
            // 使用 Center 使其居中
            child: SizedBox(
              height: 340,
              width: 375,
              child: Swiper(
                itemCount: controller.homeImages.length,
                autoplay: true, // 启用自动滑动
                autoplayDelay: 3000, // 设置自动滑动的时间为 3 秒
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(controller.homeImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
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

  Widget _title() {
    return const SizedBox(
      width: 345,
      child: Text(
        '深圳一定要去的绝美宠物友好海滩',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    );
  }

  Widget _content() {
    return const SizedBox(
      width: 345,
      child: Opacity(
        opacity: 0.80,
        child: Text(
          '下了接近2周的雨终于停了，趁着天气转晴终于可以带着咪宝一起去海边了。\n这个时间的人很少，狗子可以开心的肆意奔跑。海边的风景，因为有了狗狗的陪伴，变得更加生动而富有情感。',
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
            height: 2,
          ),
        ),
      ),
    );
  }

  Widget _time() {
    return const SizedBox(
      width: 345,
      child: Opacity(
          opacity: 0.40,
          child: Row(
            children: [
              Text(
                '编辑于 10-03 广东',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(width: 190),
              Opacity(
                  opacity: 0.90,
                  child: Row(
                    children: [
                      Icon(Icons.share, size: 14),
                      SizedBox(width: 10),
                      Text(
                        '分享',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }

  Widget _line() {
    return Container(
      width: 345,
      height: 0.1,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.black),
    );
  }

  Widget _comment() {
    return Container(
      width: 375,
      height: 228,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC4C4C4),
                    shape: OvalBorder(),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 5),
                              Opacity(
                                opacity: 0.30,
                                child: Text(
                                  'Nauynip',
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
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Opacity(
                            opacity: 0.80,
                            child: Text(
                              ' 这个沙滩 狗狗可以下水吗',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.8999999761581421),
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.50,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Icon(Icons.favorite_border),
                        ),
                      ),
                      const Opacity(
                        opacity: 0.60,
                        child: Text(
                          '12',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 307,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC4C4C4),
                    shape: OvalBorder(),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 5),
                              Opacity(
                                opacity: 0.30,
                                child: Text(
                                  '咪宝&臭宝',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 1, left: 3, right: 3),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.89, -0.45),
                                    end: Alignment(-0.89, 0.45),
                                    colors: [
                                      Colors.white,
                                      Colors.white.withOpacity(0)
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '作者',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
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
                        SizedBox(
                          width: double.infinity,
                          child: Opacity(
                            opacity: 0.80,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0), // 设置 5 的边距
                              child: Text(
                                '可以的，可以下水，但建议避开人太多的时候会更好',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.90),
                                  fontSize: 14,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                  height: 1.2, // 可以调整行高
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.50,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Icon(Icons.favorite_border),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 307,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC4C4C4),
                    shape: OvalBorder(),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 5),
                              Opacity(
                                opacity: 0.30,
                                child: Text(
                                  'Nauynip 回复 咪宝&臭宝',
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
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Opacity(
                            opacity: 0.80,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              // 设置 5 的边距
                              child: Text(
                                '好的，谢谢！',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.8999999761581421),
                                  fontSize: 14,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Opacity(
                        opacity: 0.50,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Icon(Icons.favorite_border),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 265,
            child: Opacity(
              opacity: 0.60,
              child: Text(
                '查看所有回复',
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true, // 实现透明导航
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 170.0,
          leading: Row(
            children: [
              const SizedBox(width: 11),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 24,
                height: 24,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '咪宝&臭宝',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 1, // 调整行高
                ),
              ),
            ],
          ),

          actions: const [
            Icon(
              Icons.share,
              size: 20,
              color: Colors.black,
            ),
            SizedBox(width: 15)
          ],

          toolbarHeight: 50, // 根据需要调整高度
          elevation: 0, // 去掉阴影
        ),
        body: Column(
          children: [
            _contentImg(),
            const SizedBox(height: 15),
            _title(),
            const SizedBox(height: 10),
            _content(),
            const SizedBox(height: 10),
            _time(),
            const SizedBox(height: 15),
            _line(),
            _comment()
          ],
        ));
  }
}
