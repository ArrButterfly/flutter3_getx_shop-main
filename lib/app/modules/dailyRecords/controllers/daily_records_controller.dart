import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/user_mmw_model.dart';
import '../../../units/userServices.dart';
import '../../../units/httpsMmwClient.dart';

class DailyRecordsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //用户id
  RxString userId = ''.obs;
  RxBool isLogin = false.obs;
  var userInfo = UserMmwModel().obs; //把用户信息模块化

  //用户的宠物模块化
  var userPetsModel = <UserPetsModel>[].obs; // 声明为 RxList

  HttpsMmwClient httpsClient = HttpsMmwClient();

  //是否拥有宠物信息
  RxBool userPet = false.obs;

  late TabController tabController; // 声明 TabController

  //精神状态
  RxBool mentalState = false.obs;

  RxMap<String, dynamic> mentaData = {
    // "spiritStatus": "",
    "spiritPlayTime": "",
    "spiritSleepTime": "",
  }.obs;

  // 社交互动
  RxBool socialInteraction = false.obs;

  //今日进食
  RxBool eatToday = false.obs;
  RxMap<String, dynamic> eatTodayData = {
    // "spiritStatus": "",
    "foodType": "",
    "foodAmount": "",
  }.obs;

  //今日饮水
  RxBool drinkWaterToday = false.obs;
  //今日排泄
  RxBool excretionToday = false.obs;
  //今日体重
  RxBool todayWeight = false.obs;

  //总数据
  RxMap<String, dynamic> recordsData = {
    "id": "1863497298513719298",
    "creator": 0,
    "createTime": "2024-12-02T16:15:53",
    "updateTime": "2024-12-02T20:37:56.065099",
    "deleteStatus": 0,
    "userId": "2",
    "petId": null,
    "spiritStatus": "",
    "spiritPlayTime": "",
    "spiritSleepTime": "",
    "spiritAdvise": null,
    "spiritUploadStatus": null,
    "socialStatus": null,
    "interactionTime": null,
    "interactionType": null,
    "socialAdvise": null,
    "socialUploadStatus": null,
    "foodStatus": null,
    "foodType": null,
    "foodAmount": '',
    "foodUnit": null,
    "foodAdvise": null,
    "foodUploadStatus": null,
    "hydrateStatus": null,
    "hydrateAmount": null,
    "hydrateUnit": null,
    "hydrateAdvise": null,
    "hydrateUploadStatus": null,
    "poopStatus": null,
    "poopType": null,
    "poopShape": null,
    "poopSmell": null,
    "poopAmount": null,
    "urineType": null,
    "urineSmell": null,
    "urineSize": null,
    "poopAdvise": null,
    "poopUploadStatus": null,
    "weightStatus": null,
    "weightAmount": null,
    "weightUnit": null,
    "weightShape": null,
    "weightMuscle": null,
    "weightAdvise": null,
    "weightUploadStatus": null
  }.obs;

  //一键记录按钮
  RxBool oneClickRecordButton = true.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this); // 初始化 TabController
    //获取用户信息与宠物信息
    getUserInfo().then((_) {
      getUserPetsModel();
    });
  }

  @override
  void onClose() {
    tabController.dispose(); // 释放 TabController
    super.onClose();
  }

  //获取用户信息
  getUserInfo() async {
    var tempLoginState = await UserServices.getUserLoginState();
    isLogin.value = tempLoginState;
    var tempList = await UserServices.getUserInfo();
    if (tempList.isNotEmpty) {
      var userData = tempList[0]['data'];
      userInfo.value = UserMmwModel.fromJson(userData); // 使用 userData
      update();
      print(userInfo.value.toString());
    }

    print("查看用户是否已登录------------------" "$isLogin");
    print(userInfo.value.id);
  }

// 获取宠物
  getUserPetsModel() async {
    userId.value = userInfo.value.id.toString();
    var user = userId.value;

    var responsePet =
        await httpsClient.get("api/account/pet/petsOfUser?userId=$user");

    // 确保返回的数据是一个 List
    if (responsePet.data["data"] is List) {
      userPetsModel.assignAll(responsePet.data["data"]
          .map<UserPetsModel>((pet) => UserPetsModel.fromJson(pet))
          .toList());

      userPet.value = userPetsModel.isNotEmpty;
      // 打印用户宠物模型
      print("用户宠物模型: $userPetsModel");
    } else {
      print("返回的数据不是一个 List");
    }
  }

  tabBarChoose() {
    print("点击选择器");
  }

  void expandView(int type) {
    final Map<int, RxBool> stateMap = {
      1: mentalState,
      2: socialInteraction,
      3: eatToday,
      4: drinkWaterToday,
      5: excretionToday,
      6: todayWeight,
    };

    if (stateMap.containsKey(type)) {
      // 切换当前状态
      stateMap[type]!.value = !stateMap[type]!.value;

      // 检查是否有任何状态为 true
      oneClickRecordButton.value = !stateMap.values.any((state) => state.value);

      // 如果所有状态都为 false，设置 oneClickRecordButton 为 true
      // 如果有一个状态为 true，设置为 false
    }
  }

  statusBlockClick(String name, int type) {
    print(name);
    print(type);
    if (type == 1) {
      // mentaData['spiritStatus'] = name;
      // recordsData['spiritStatus'] = name;
    }
    if (type == 2) {
      mentaData['spiritPlayTime'] = name;
      recordsData['spiritPlayTime'] = name;
    }
    if (type == 3) {
      mentaData['spiritSleepTime'] = name;
      recordsData['spiritSleepTime'] = name;
    }
    if (type == 8) {
      eatTodayData['foodType'] = name;
      recordsData['foodType'] = name;
    }
  }

  //上传宠物记录
  petHealthUpload(String name) async {
    print("上传宠物健康记录");
    print(name);
    if (name == '精神状态') {
      mentaData['userId'] = userInfo.value.id.toString(); // 确保 userId 是正确的
      mentaData['petId'] = '1860956625679892482';
      // 获取今天的日期并格式化为 'YYYY-MM-DD'
      DateTime now = DateTime.now();
      String formattedDate =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      mentaData['date'] = formattedDate;

      // 打印 mentaData 的所有键和值
      mentaData.forEach((key, value) {
        print('$key: $value');
      });

      // 发送请求
      var responsePetHealth =
          await httpsClient.post("api/tools/petHealthUpload", data: mentaData);

      // 处理响应
      if (responsePetHealth.statusCode == 200) {
        var petHealthData = responsePetHealth.data['data'];
        //开始赋值
        recordsData['spiritStatus'] = petHealthData['spiritStatus'];
        recordsData['spiritPlayTime'] = petHealthData['spiritPlayTime'];
        recordsData['spiritSleepTime'] = petHealthData['spiritSleepTime'];

        print("打印查看！！！");
        print(recordsData['spiritStatus']);
        print(recordsData['spiritPlayTime']);
        print(recordsData['spiritSleepTime']);
      }
      if (responsePetHealth != null) {
        // print("上传成功: ${responsePetHealth.data}");
      } else {
        print("上传失败");
      }
    }
    if (name == '今日进食') {
      eatTodayData['userId'] = userInfo.value.id.toString(); // 确保 userId 是正确的
      eatTodayData['petId'] = '1860956625679892482';

      // 获取今天的日期并格式化为 'YYYY-MM-DD'
      DateTime now = DateTime.now();
      String formattedDate =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      eatTodayData['date'] = formattedDate;

      // 打印 eatTodayData 的所有键和值
      eatTodayData.forEach((key, value) {
        print('$key: $value');
      });

      // 发送请求
      var responsePetHealth = await httpsClient
          .post("api/tools/petHealthUpload", data: eatTodayData);

// 处理响应
      if (responsePetHealth.statusCode == 200) {
        var petHealthData = responsePetHealth.data['data'];
        //开始赋值
        if (petHealthData != null) {
          recordsData['foodStatus'] = petHealthData['foodStatus'];
          recordsData['foodType'] = petHealthData['foodType'];
          recordsData['foodAmount'] = petHealthData['foodAmount'];
        }

        print("打印查看！！！");
        print(recordsData['spiritStatus']);
        print(recordsData['spiritPlayTime']);
        print(recordsData['spiritSleepTime']);
      }
    }
  }

  //点击输入框
  clickInputBox(int type) {
    print(type);
    print(eatTodayData['foodAmount']);
    print(recordsData['foodAmount']);
  }
}
