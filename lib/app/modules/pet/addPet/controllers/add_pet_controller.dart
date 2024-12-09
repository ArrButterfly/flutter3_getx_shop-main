import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/add_pet.dart';
import '../../../../units/httpsMmwClient.dart';

import '../../../../models/message_mmw.dart';
import '../../../../units/storage.dart';
import '../../../../modules/tabs/views/tabs_view.dart';

class AddPetController extends GetxController {
  var addPet = AddPetModel(
          fromUserId: 2, breedId: 1, gender: 0, sterilized: 0, weight: "0")
      .obs; //把用户信息模块化
  var petName = ''.obs; //宠物姓名
  var selectedGender = ''.obs; // 性别
  var selectedSterilized = ''.obs; // 绝育
  var selectedColor = ''.obs; // 颜色
  var selectedBirthday = ''.obs; // 生日
  var selectedArrivalDay = ''.obs; // 到家日

  HttpsMmwClient httpsClient = HttpsMmwClient();

  TextEditingController telController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addPetName() {
    addPet.value.nickName = telController.text;
    petName.value = telController.text;
    print(addPet.value.nickName);
  }

  void updateValue(String value, int type) {
    if (type == 0) {
      addPet.value.gender = value == "弟弟" ? 0 : 1;
      selectedGender.value = value; // Update the selected gender
    } else if (type == 1) {
      addPet.value.sterilized = value == "已绝育" ? 1 : 0;
      selectedSterilized.value = value; // Update the selected sterilized
    } else if (type == 2) {
      addPet.value.color = value;
      selectedColor.value = value;
    } else if (type == 3) {
      addPet.value.weight = value;
    }
    //生日
    else if (type == 4) {
      selectedBirthday.value = value;
      addPet.value.birthday = value;
    }
    //到家日
    else if (type == 5) {
      selectedArrivalDay.value = value;
      addPet.value.arrivedDay = value;
    }
    print("接收到值：$value+$type");
  }

  //保存资料

  Future<MessageMmwModel> addPetData() async {
    try {
      print("宠物信息打印________-----");
      print(addPet.toJson());
      var response = await httpsClient.post("api/account/pet/addPet",
          data: addPet.toJson());

      print(response);
      if (response != null && response.statusCode == 200) {
        // 使用 response.data 访问内容
        if (response.data['code'] == 200) {
          print("开始保存用户信息");
          // 假设用户信息在 data 字段中，您可以将其转换为 List
          print(response.data["data"].toString());
          var petdata = response.data["data"]; // 获取宠物id
          //打印id
          print("打印宠物id--------------->");
          print(petdata['id']);
          var petId = petdata['id'];
          var userId = petdata['userId'];

          //获取宠物token
          var responsePet = await httpsClient.get(
              "api/account/pet/generateTokenForPet?userId=$userId&petId=$petId");

          print("打印宠物token");
          print(responsePet.data["data"]);
          var petToken = responsePet.data["data"];

          //绑定宠物到用户账户里
          var responseAddUser = await httpsClient.put(
              "api/account/pet/linkPetToUser?petId=$petId&userId=$userId&token=$petToken");

          print("打印用户的宠物情况");
          print(responseAddUser.data);

          if (responseAddUser.data["code"] == 200) {
            Get.snackbar("提示信息", "添加成功");
            //跳转到我的 清除回退页面栈信息

            Get.offNamed("/id_card_view");
          }

          return MessageMmwModel(message: "登录成功", code: 200);
        }
        return MessageMmwModel(message: response.data["message"], code: 500);
      } else {
        return MessageMmwModel(message: "网络异常", code: 502);
      }
    } catch (e) {
      print("请求异常: $e");
      return MessageMmwModel(message: "请求异常", code: 502);
    }
  }
}
