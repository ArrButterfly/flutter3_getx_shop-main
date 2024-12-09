import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../units/httpsMmwClient.dart';
import '../../../units/storage.dart';
import 'dart:async'; // 导入 Timer 所需的库

class ActivitiesController extends GetxController {
  HttpsMmwClient httpsClient = HttpsMmwClient();
  // 用户猫粮
  RxInt score = 0.obs;

  //抽奖
  RxInt scoreUpdate = 0.obs;

  //捐赠猫粮停留效果
  RxBool animationEffects = false.obs;

  //任务总数据
  RxMap totalTaskData = {}.obs;

  //任务list
  RxList<Map<String, dynamic>> taskList = <Map<String, dynamic>>[].obs;

  //每日健康list
  RxList dailyUploadTasksList =
      [2, 2, 2, 2, 2, 20, 20, 35, 20, 20, 1, 2, 3, 4, 5].obs;

  //每日健康按钮文字
  RxString rewardText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    //获取任务
    getTotalTaskData();
    //获取每日健康上传奖励
    getDailyUploadTasks();

    getUserScore(); // 可以在初始化时调用获取分数
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 查询猫粮剩余
  void getUserScore() async {
    var responsePet =
        await httpsClient.get("api/account/user/userProperty?userId=2");

    // 检查响应的状态码
    if (responsePet != null && responsePet.statusCode == 200) {
      // 从响应主体中提取数据
      var data = responsePet.data;

      // 从数据中提取 score 并赋值给 RxInt score
      score.value = data['data']['score'];

      print(score.value);
    } else {
      // 处理错误情况，例如显示消息或记录错误
      print('Error: ${responsePet?.data['message'] ?? '未知错误'}');
    }
  }

  //抽奖
  void lottery() async {
    var lotteryResponse =
        await httpsClient.put("api/account/user/dailyTask/lottery?userId=2");

    // 检查响应的状态码
    if (lotteryResponse != null && lotteryResponse.statusCode == 200) {
      // 从响应主体中提取数据
      var data = lotteryResponse.data['data'];

      // 获取最终的 scoreUpdate 值
      int finalScoreUpdate = data['scoreUpdate'];

      score.value = data['score'];

      // 初始化当前的 scoreUpdate
      scoreUpdate.value = 0; // 初始化为 0

      // 定义要跳动的值
      List<int> jumpValues = [50, 100, 200, 300, 400];

      // 定义一个计数器
      int index = 0;

      // 创建一个定时器
      Timer timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
        if (index < jumpValues.length) {
          // 更新 scoreUpdate
          scoreUpdate.value = jumpValues[index];
          index++;
        } else {
          // 停止计时器并设置最终的 scoreUpdate 值
          timer.cancel();
          scoreUpdate.value = finalScoreUpdate; // 设置最终值
        }
      });

      // 测试重制次数
      var testResponse = await httpsClient
          .put("api/account/user/dailyTask/debug/resetLottery?userId=2");
      if (testResponse.statusCode == 200) {}
      print(score.value);
    } else {
      // 处理错误情况，例如显示消息或记录错误
      print('Error: ${lotteryResponse?.data['message'] ?? '未知错误'}');
    }
  }

  //捐赠猫粮
  void donate() async {
    if (score.value < 200) {
      Get.snackbar("提示", "猫粮不足");
      return;
    }
    var donateResponse = await httpsClient
        .put("api/account/user/ngo/action?userId=2&ngoName=%E5%96%82%E5%85%BB");
    if (donateResponse.statusCode == 200) {
      var data = donateResponse.data['data'];
      score.value = data['score'];
      Get.snackbar("猫粮 -${data['scoreUpdate']}", "捐赠成功");

      // 设置动画效果为 true
      animationEffects.value = true;

      // 延迟 2 秒后将动画效果设置为 false
      Future.delayed(const Duration(seconds: 2), () {
        animationEffects.value = false;
      });
    }
  }

  //获取任务总数据
  void getTotalTaskData() async {
    try {
      var response = await httpsClient.get("api/account/user/ngo/uni?userId=2");
      if (response.statusCode == 200) {
        totalTaskData.value = response.data['data'];

        // 使用 assignAll 更新任务列表
        // 确保将 List<dynamic> 转换为 List<Map<String, dynamic>>
        List<Map<String, dynamic>> tasks =
            List<Map<String, dynamic>>.from(totalTaskData['taskVOS']);

        // 使用 assignAll 更新任务列表
        taskList.assignAll(tasks);

        print("list数据获取成功: ${taskList}"); // 输出任务列表
      } else {
        print("请求失败: ${response.statusCode}");
      }
    } catch (e) {
      print("发生错误: $e");
    }
  }

  //获取每日上传健康任务
  void getDailyUploadTasks() async {
    try {
      var response = await httpsClient.get(
          "api/account/user/dailyTask/status?userId=2&taskType=pet_health_upload_task_v2");
      if (response.statusCode == 200) {
        dailyUploadTasksList.value = response.data['data'];

        print("每日健康奖励list数据获取成功: ${dailyUploadTasksList}"); // 输出任务列表
      } else {
        print("请求失败: ${response.statusCode}");
      }
    } catch (e) {
      print("发生错误: $e");
    }
  }

// 每日健康按钮显示结果
  String dailyUploadTasksText() {
    rewardText.value = '去填写'; // 默认文本

    // 检查 dailyUploadTasksList 的前五个值
    bool hasClaimed = false;
    for (int i = 0; i < 5; i++) {
      if (dailyUploadTasksList[i] == 1) {
        hasClaimed = true;
        // 检查下一个下标
        if (i + 1 < dailyUploadTasksList.length) {
          if (dailyUploadTasksList[i + 1] == -1) {
            rewardText.value = '可领取'; // 如果下一个是 -1
          } else if (dailyUploadTasksList[i + 1] == 2) {
            rewardText.value = '去填写'; // 如果下一个是 2
          } else if (dailyUploadTasksList[i + 1] == 1) {
            rewardText.value = '已领取'; // 如果下一个是 1
          }
        }
        break; // 找到第一个 1 后退出循环
      }
    }

    // 如果没有 1，检查是否全为 2
    if (!hasClaimed &&
        dailyUploadTasksList.sublist(0, 5).every((value) => value == 2)) {
      rewardText.value = '去填写';
    }

    return rewardText.value; // 返回最终的文本
  }

  //点击按钮健康按钮
  rewardTextButton() {
    if (rewardText.value == '去填写') {
      Get.toNamed("/daily_records_view");
      return;
    }
    if (rewardText.value == '可领取') {
      Get.snackbar("提示", "已领取奖励30g");
      return;
    }
    if (rewardText.value == '已领取') {
      Get.snackbar("提示", "已领取奖励,请勿重复点击！");
      return;
    }
  }
}
