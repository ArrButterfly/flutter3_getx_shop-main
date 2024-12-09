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

import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../controllers/ai_chat_controller.dart';

class AiChatView extends GetView<AiChatController> {
  const AiChatView({Key? key}) : super(key: key);

  Widget _homeHeaderSwiper() {
    return Container(
        width: double.infinity,
        height: 176,
        child: ListView(
          scrollDirection: Axis.horizontal, // 设置为水平滑动
          children: [
            Container(
              width: 124,
              height: 176,
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: Text(
                      '猫一般多久需要洗一次澡？',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.10,
                    child: Container(
                      width: double.infinity,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Opacity(
                      opacity: 0.60,
                      child: Text(
                        '建议长毛的猫2个月~3个月洗一次，短毛的猫3个月~5个月洗一次，无毛猫一星期洗1次~2次。',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xFF333333),
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
            ),
            const SizedBox(width: 5),
            Container(
              width: 126,
              height: 176,
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: Text(
                      '我的猫为什么喜欢啃墙？',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.10,
                    child: Container(
                      width: double.infinity,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Opacity(
                      opacity: 0.60,
                      child: Text(
                        '如果是咬墙壁的话要注意哦，可能是身体缺乏微量元素了，要及时给猫咪补充哦。',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xFF333333),
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
            ),
            const SizedBox(width: 5),
            Container(
              width: 126,
              height: 176,
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: Text(
                      '猫为什么总舔“我”',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.10,
                    child: Container(
                      width: double.infinity,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Opacity(
                      opacity: 0.60,
                      child: Text(
                        '这是猫咪在表达对你的喜欢，猫咪中只有接受你把你当自己“猫”才会帮你舔毛的哦。',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xFF333333),
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
            )
          ],
        ));
  }

  Widget _preSuggestion() {
    return Container(
      width: 165,
      height: 200,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              '猜你想问',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: Opacity(
              opacity: 0.60,
              child: Text(
                '狗狗浑身发抖是怎么回事？',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: Opacity(
              opacity: 0.60,
              child: Text(
                '博美几个月适合训练',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: Opacity(
              opacity: 0.60,
              child: Text(
                '刚出生的小猫喂什么',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: Opacity(
              opacity: 0.60,
              child: Text(
                '猫咪肚子上的豆豆是什么？',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: Opacity(
              opacity: 0.60,
              child: Text(
                '换一批',
                style: TextStyle(
                  color: Color(0xFF333333),
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

  Widget _meMessage() {
    return Container(
      width: 300,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              child: Text(
                '12岁松狮犬，睾丸肿瘤上周切除，肿瘤物送去病理检测，(检查报告已上传)检测结果上说是精原细胞瘤，这个是属于良性还是恶性?术后需要怎么处理?',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFF333333),
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
    );
  }

  Widget _aiMessage() {
    return Container(
      width: 285,
      height: 76,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '您的问题AI无法解答，是否咨询在线医生？',
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
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.60,
                        child: Text(
                          '前往咨询在线医生',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
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
        ],
      ),
    );
  }

  Widget _notice() {
    return const SizedBox(
      width: 335,
      child: Opacity(
        opacity: 0.60,
        child: Text(
          '今日还能免费问诊3次',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 12,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
    );
  }

  Widget _inputBox() {
    return Container(
      width: 345,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: const Icon(
              Icons.image_outlined,
              size: 20,
              color: Colors.grey,
            ),
          ),
          Opacity(
            opacity: 0.60,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Icon(
                Icons.message,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(
              child: Opacity(
                opacity: 0.30,
                child: Text(
                  ' 来和我说说宠物的问题吧',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: ShapeDecoration(
              color: Color(0xFFA1A1A1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '发送',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true, // 实现透明导航
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),

          leading: InkWell(
            onTap: () {
              // 点击事件处理
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'AI问诊',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 17,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),

          toolbarHeight: 50, // 根据需要调整高度
          elevation: 0, // 去掉阴影
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // 设置左右边距为 20
            child: Column(
              children: [
                const SizedBox(height: 108),
                _homeHeaderSwiper(),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft, // 左对齐
                  child: _preSuggestion(),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight, // 右对齐
                  child: _meMessage(),
                ),
                const SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerLeft, // 左对齐
                    child: _aiMessage()),
                const SizedBox(height: 10),
                _notice(),
                const SizedBox(height: 8),
                _inputBox()
              ],
            )));
  }
}
