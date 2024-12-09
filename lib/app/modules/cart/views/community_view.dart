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
import '../controllers/community_controller.dart';
import '../../../units/keepAliveWrapper.dart'; //缓存状态
import '../../../units/screenAdapter.dart'; //适配
import '../../../units/myFonts.dart'; //引入字标库
import 'package:flutter_swiper_view/flutter_swiper_view.dart'; //轮播图
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; //瀑布流
import '../../../units/httpsClient.dart'; //封装的dio

class CommunityView extends GetView<CommunityController> {
  const CommunityView({Key? key}) : super(key: key);

// 顶部导航
  Widget _appBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
        title: InkWell(
            child: Row(
              children: [
                const Text(
                  '全部',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 16.43),
                const Text(
                  '推荐',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(width: 16.43),
                _caidan("走失"),
                _caidan("求助"),
                _caidan("投喂"),
                _caidan("领养"),
              ],
            ),
            onTap: () {
              print("菜单栏");
            }),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/serach');
              },
              icon: const Icon(Icons.search, color: Colors.black87))
        ],
      ),
    );
  }

  Widget _caidan(String name) {
    return Row(
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        SizedBox(width: 16.43),
      ],
    );
  }

//瀑佈流商品
  Widget _bestGoods() {
    return Column(
      children: [
        const SizedBox(height: 100),
        Obx(() => Container(
              padding: EdgeInsets.all(ScreenAdapter.width(5)),
              color: const Color.fromRGBO(246, 246, 246, 1),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: ScreenAdapter.width(6),
                crossAxisSpacing: ScreenAdapter.width(6),
                itemCount: controller.bestPlist.length, //注意
                shrinkWrap: true, //收缩，让元素宽度自适应
                physics: const NeverScrollableScrollPhysics(), //禁止滑动
                itemBuilder: (context, index) {
                  var picUrl =
                      "https://miapp.itying.com/${controller.bestPlist[index].sPic}";
                  return InkWell(
                    onTap: () {
                      Get.toNamed("/product-content",
                          arguments: {"id": controller.bestPlist[index].sId});
                    },
                    child: Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: Image.network(
                              picUrl.replaceAll("\\", "/"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            width: double.infinity,
                            child: Text(
                              // "${controller.bestPlist[index].title}",
                              "我家宠物好可爱哦！",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(12),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(ScreenAdapter.width(10)),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFD9D9D9),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    // "¥${controller.bestPlist[index].price}",
                                    "喵宝",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(12),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 50),
                                  Opacity(
                                    opacity: 0.50,
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Opacity(
                                    opacity: 0.60,
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ))
      ],
    );
  }

  //内容区域
  Widget _homePage() {
    return Positioned(
        top: -40,
        left: 0,
        right: 0,
        bottom: 0,
        child: ListView(
          controller: controller.scrollController,
          children: [
            _bestGoods(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
      body: Stack(
        children: [
          _homePage(),
          _appBar(),
        ],
      ),
    ));
  }
}
