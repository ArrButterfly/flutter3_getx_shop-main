import 'package:get/get.dart';
import '../../../../units/httpsMmwClient.dart';
import '../../../../units/userServices.dart';
import '../../../../models/message_mmw.dart';
import '../../../../models/user_mmw_model.dart';

class IdCardController extends GetxController {
  RxBool isLogin = false.obs;
  //用户的宠物模块化
  var userPetsModel = <UserPetsModel>[].obs; // 声明为 RxList

  var userInfo = UserMmwModel().obs; //把用户信息模块化

  HttpsMmwClient httpsClient = HttpsMmwClient();

  @override
  void onInit() {
    super.onInit();
    print("选择用户宠物方法被调用----");
    //获取用户信息与宠物信息
    getUserInfo().then((_) {
      selecUserPet();
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("选择用户宠物方法被吊销");
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
  }

  selecUserPet() async {
    var userId = userInfo.value.id;
    var responsePet =
        await httpsClient.get("api/account/pet/petsOfUser?userId=$userId");

    // 打印 API 返回的数据
    print("API 返回的宠物数据: ${responsePet.data["data"]}");

    // 确保返回的数据是一个 List
    if (responsePet.data["data"] is List) {
      userPetsModel.assignAll(responsePet.data["data"]
          .map<UserPetsModel>((pet) => UserPetsModel.fromJson(pet))
          .toList());

      // 打印用户宠物模型
      print("用户宠物模型: $userPetsModel");
    } else {
      print("返回的数据不是一个 List");
    }
  }
}
