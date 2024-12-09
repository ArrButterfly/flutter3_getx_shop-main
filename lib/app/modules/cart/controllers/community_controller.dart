/*
 * @Descripttion: 
 * @version: 
 * @Author: lee
 * @Date: 2024-11-28 13:54:07
 * @LastEditTime: 2024-03-06 16:32:40
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:dio/dio.dart';
import '../../../models/focus_model.dart';
import '../../../models/category_model.dart';
import '../../../models/notes_plist_model.dart';
import '../../../models/plist_model.dart';
import '../../../units/httpsClient.dart';
import '../../../units/httpsMmwClient.dart';

class CommunityController extends GetxController {
  //浮动导航开关
  RxBool flag = false.obs;
  //监听滑动
  final ScrollController scrollController = ScrollController();
  RxList<FocusItemModel> swiperList = <FocusItemModel>[].obs; //注意需要定义成响应式数据
  RxList<FocusItemModel> bestSellingSwiperList = <FocusItemModel>[].obs;
  RxList<CategoryItemModel> categoryList = <CategoryItemModel>[].obs;
  RxList<PlistItemModel> sellingPlist = <PlistItemModel>[].obs;
  RxList<PlistItemModel> bestPlist = <PlistItemModel>[].obs;
  // ignore: unnecessary_new
  HttpsClient httpsClient = new HttpsClient();

  HttpsMmwClient httpsClientPet = HttpsMmwClient();

  var tags = <NotesPlistModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    //获取标签组
    // getTagGroup();

    // 获取热门商品
    getBestPlistData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //获取热门商品数据
  getBestPlistData() async {
    var response = await httpsClient.get("api/plist?is_best=1");
    if (response != null) {
      var plist = PlistModel.fromJson(response.data);
      bestPlist.value = plist.result!;
      update();
    }
  }

  getTagGroup() async {
    try {
      var responsePet =
          await httpsClientPet.get("api/community/base/getTags/0/6");

      // 确保 responsePet 和 data 不为 null
      if (responsePet != null && responsePet.data != null) {
        var data = responsePet.data;

        // 确保 data 是一个 Map，并且包含 children
        if (data is Map<String, dynamic> && data.containsKey('children')) {
          var children = data['children'];

          // 检查 children 是否为 List
          if (children is List) {
            // 将 children 转换为 NotesPlistModel 的列表
            var tagsList = children
                .map<NotesPlistModel>((pet) => NotesPlistModel.fromJson(pet))
                .toList();
            tags.assignAll(tagsList); // 将 tagsList 赋值给 tags
          } else {
            print("Children is not a List.");
          }
        } else {
          print("Data does not contain children or is not a Map.");
        }
      } else {
        print("Response is null or does not contain data.");
      }

      print("标签组: $tags");
    } catch (e) {
      print("Error fetching tags: $e");
    }
  }
}
