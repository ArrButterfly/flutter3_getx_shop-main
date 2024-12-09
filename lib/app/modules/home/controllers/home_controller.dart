/*
 * @Descripttion: 
 * @version: 
 * @Author: kiko
 * @Date: 2024-02-21 10:54:07
 * @LastEditors: web-kiko kikoiiii@163.com
 * @LastEditTime: 2024-03-06 16:32:40
 */
import 'package:get/get.dart';
// import 'package:dio/dio.dart';
import '../../../units/HttpsMmwClient.dart';
import 'dart:async';
import '../../../models/user_mmw_model.dart';
import '../../../units/userServices.dart';

class HomeController extends GetxController {
  //浮动导航开关
  // RxBool flag = false.obs;
  // //监听滑动
  // final ScrollController scrollController = ScrollController();
  // RxList<FocusItemModel> swiperList = <FocusItemModel>[].obs; //注意需要定义成响应式数据
  // RxList<FocusItemModel> bestSellingSwiperList = <FocusItemModel>[].obs;
  // RxList<CategoryItemModel> categoryList = <CategoryItemModel>[].obs;
  // RxList<PlistItemModel> sellingPlist = <PlistItemModel>[].obs;
  // RxList<PlistItemModel> bestPlist = <PlistItemModel>[].obs;
  // ignore: unnecessary_new

  HttpsMmwClient httpsClient = new HttpsMmwClient();

  RxBool isLogin = false.obs;
  var userInfo = UserMmwModel().obs; //把用户信息模块化

  //用户的宠物模块化
  var userPetsModel = <UserPetsModel>[].obs; // 声明为 RxList

  //是否拥有宠物信息
  RxBool userPet = false.obs;

  //首页广告图:
  final List<String> homeImages = [
    'assets/images/home_advertising_picture.png',
    'assets/images/home_advertising_picture.png',
    'assets/images/home_advertising_picture.png',
  ];
  //指示灯
  var currentIndex = 0.obs;

  late final Timer timer;

  get sellingPlist => null;

  get bestSellingSwiperList => null;

  get categoryList => null;

  get swiperList => null;

  get flag => null;

  @override
  void onInit() {
    super.onInit();
    //滑动监听
    // scrollControllerListener();
    //请求接口
    // getFocusData();
    // //获取分类数据
    // getCategoryData();
    // //获取热销臻选里面的轮播图
    // getSellingSwiperData();
    // //获取热销臻选里面的商品
    // getSellingPlistData();
    // // 获取热门商品
    // getBestPlistData();

//////////
    //获取用户信息与宠物信息
    getUserInfo().then((_) {
      getUserPetsModel();
    });
  }

  @override
  void onReady() {
    super.onReady();
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
    if (!isLogin.value) {
      return;
    }
    var tempList = await UserServices.getUserInfo();
    if (tempList.isNotEmpty) {
      var userData = tempList[0]['data'];
      userInfo.value = UserMmwModel.fromJson(userData); // 使用 userData
      update();
      print(userInfo.value.toString());
    }

    print("查看用户是否已登录------------------" "$isLogin");
    print(isLogin);
    print(userInfo.value.id);
  }

// 获取宠物
  getUserPetsModel() async {
    if (!isLogin.value) {
      return;
    }
    var userId = userInfo.value.id;
    print("获取用户数据------------------》");
    print(userId);
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
      print("打印是否有登录与宠物信息>>>>>>>>>>>>>>>>>$userPet,$isLogin");
    } else {
      print("返回的数据不是一个 List");
    }
  }

  //计算年龄
  String calculateAge(String birthday) {
    DateTime birthDate = DateTime.parse(birthday);
    DateTime today = DateTime.now();

    // 计算年份
    int years = today.year - birthDate.year;

    // 如果还没到生日，年份减一
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      years--;
    }

    // 如果年份小于1，返回1年；否则返回实际年份
    return (years < 1) ? "1" : "$years";
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

  //宠物名字区域点击效果
  petNameArea() {
    if (isLogin.value) {
      // 用户已登录，跳转到修改宠物页面
      print("修改页面信息");
    } else {
      // 用户未登录，跳转到登录页面
      Get.toNamed("/code-login-step-one");
    }
  }

  //判断是否登录还是未添加宠物跳转
  addPetTips() {
    isLogin.value
        ? Get.toNamed("/add_pet_view")
        : Get.toNamed("/code-login-step-one");
  }

  //监听滚动条滚动事件
  // void scrollControllerListener() {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels > 10) {
  //       if (flag.value == false) {
  //         //print("position.pixels > 10");
  //         flag.value = true;
  //         update();
  //       }
  //     }
  //     if (scrollController.position.pixels < 10) {
  //       if (flag.value == true) {
  //         //print("position.pixels < 10");
  //         flag.value = false;
  //         update();
  //       }
  //     }
  //   });
  // }

  //获取轮播图数据
  // getFocusData() async {
  //   var response = await httpsClient.get("api/focus");
  //   if (response != null) {
  //     var focus = FocusModel.fromJson(response.data);
  //     swiperList.value = focus.result!;
  //     update();
  //   }
  // }

  //获取热销臻选里面的轮播图
  // getSellingSwiperData() async {
  //   var response = await httpsClient.get("api/focus?position=2");
  //   if (response != null) {
  //     var sellingSwiper = FocusModel.fromJson(response.data);
  //     bestSellingSwiperList.value = sellingSwiper.result!;
  //     update();
  //   }
  // }

//获取热销臻选里面的商品数据
  // getSellingPlistData() async {
  //   var response = await httpsClient.get("api/plist?is_hot=1&pageSize=3");
  //   if (response != null) {
  //     var plist = PlistModel.fromJson(response.data);
  //     sellingPlist.value = plist.result!;
  //     update();
  //   }
  // }

  //获取分类数据
  // getCategoryData() async {
  //   var response = await httpsClient.get("api/bestCate");
  //   if (response != null) {
  //     var category = CategoryModel.fromJson(response.data);
  //     categoryList.value = category.result!;
  //     update();
  //   }
  // }

  //获取热门商品数据
  // getBestPlistData() async {
  //   var response = await httpsClient.get("api/plist?is_best=1");
  //   if (response != null) {
  //     var plist = PlistModel.fromJson(response.data);
  //     bestPlist.value = plist.result!;
  //     update();
  //   }
  // }
}
