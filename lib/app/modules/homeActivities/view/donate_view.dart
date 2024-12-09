import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../controllers/activities_controller.dart';

class DonateView extends GetView<ActivitiesController> {
  DonateView({Key? key}) : super(key: key);

  // 创建 SignatureController 用于控制签名
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA1A1A1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA1A1A1),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: const Text(
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 187),
            const Text(
              '公益活动海报',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            const SizedBox(height: 220),
            GestureDetector(
              onTap: () {
                // 点击签名区域时，清空当前签名
                _signatureController.clear();
              },
              child: Container(
                width: 248,
                height: 100,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Signature(
                  controller: _signatureController,
                  width: 248,
                  height: 100,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 42),
            InkWell(
                onTap: () async {
                  // 导出签名图像
                  final Uint8List? data =
                      await _signatureController.toPngBytes();
                  if (data != null) {
                    // 显示签名图像
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('签名成功'),
                          content: SizedBox(
                            width: 300,
                            height: 200,
                            child: Image.memory(data),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                                Get.back();
                              },
                              child: const Text('完成'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  width: 248,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '自愿签署',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 12),
            const SizedBox(
              width: 170,
              height: 14,
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 12,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '我已阅读并同意《公益活动条约》',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 38),
          ],
        ),
      ),
    );
  }
}
