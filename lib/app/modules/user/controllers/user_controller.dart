import 'package:get/get.dart';

import '../../../models/user_mmw_model.dart';
import '../../../units/userServices.dart';
import '../../../units/httpsMmwClient.dart';

class UserController extends GetxController {
  RxBool isLogin = false.obs;
  var userInfo = UserMmwModel().obs; //把用户信息模块化

  //用户的宠物模块化
  var userPetsModel = <UserPetsModel>[].obs; // 声明为 RxList

  HttpsMmwClient httpsClient = HttpsMmwClient();

  //是否拥有宠物信息
  RxBool userPet = false.obs;

  @override
  void onInit() {
    super.onInit();

    //获取用户信息与宠物信息
    getUserInfo().then((_) {
      getUserPetsModel();
    });
  }

  @override
  void onClose() {
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
    var userId = userInfo.value.id;
    var responsePet =
        await httpsClient.get("api/account/pet/petsOfUser?userId=$userId");

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

  //计算年龄
  String calculateAge(String birthday) {
    DateTime birthDate = DateTime.parse(birthday);
    DateTime today = DateTime.now();

    // 计算年龄的年份、月份和天数
    int years = today.year - birthDate.year;
    int months = today.month - birthDate.month;
    int days = today.day - birthDate.day;

    // 如果天数为负数，借用一个月
    if (days < 0) {
      months--;
      days += DateTime(today.year, today.month, 0).day; // 获取上个月的天数
    }

    // 如果月份为负数，借用一年
    if (months < 0) {
      years--;
      months += 12; // 加上12个月
    }

    // 构建返回字符串
    List<String> ageParts = [];
    if (years > 0) {
      ageParts.add("$years岁");
    }
    if (months > 0) {
      ageParts.add("$months个月");
    }
    if (days > 0) {
      ageParts.add("$days天");
    }

    // 如果没有有效的年龄部分，返回空字符串
    return ageParts.isNotEmpty ? ageParts.join(" ") : "";
  }

  //生日
  int daysUntilNextBirthday(String birthday) {
    DateTime birthDate = DateTime.parse(birthday);
    DateTime today = DateTime.now();

    // 获取今年的生日日期
    DateTime nextBirthday =
        DateTime(today.year, birthDate.month, birthDate.day);

    // 如果今年的生日已经过去，计算明年的生日
    if (nextBirthday.isBefore(today)) {
      nextBirthday = DateTime(today.year + 1, birthDate.month, birthDate.day);
    }

    // 计算距离下一个生日的天数
    return nextBirthday.difference(today).inDays;
  }

  //到家多久
  int daysSinceArrivedDay(String arrivedDay) {
    DateTime arrivalDate = DateTime.parse(arrivedDay);
    DateTime now = DateTime.now();
    return now.difference(arrivalDate).inDays; // 计算已过去的天数
  }

//退出登录
  loginOut() {
    UserServices.loginOut();
    isLogin.value = false;
    //把信息值为空
    userInfo.value = UserMmwModel();
    update();
  }
}
