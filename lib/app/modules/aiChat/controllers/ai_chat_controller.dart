/*
 * @ Author: lee
 * @ Create Time: 2024-03-21 02:39:33
 * @ Modified time: 2024-04-03 02:54:21
 */

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../models/pcontent_model.dart';
import '../../../units/httpsClient.dart';
import '../../../units/screenAdapter.dart';
import '../../../units/cartServices.dart';
import '../../../units/storage.dart';
import '../../../units/userServices.dart';

class AiChatController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final List<String> homeImages = [
    'assets/images/cat_1.png',
    'assets/images/cat_2.png',
    'assets/images/cat_3.png',
  ];

  //指示灯
  var currentIndex = 0.obs;

  HttpsClient httpsClient = HttpsClient();
  //导航的透明度
  RxDouble opcity = 0.0.obs;
  //是否显示tabs
  RxBool showTabs = false.obs;
  List tabsList = [
    {
      "id": 1,
      "title": "商品",
    },
    {"id": 2, "title": "详情"},
    {"id": 3, "title": "推荐"}
  ];
  RxInt selectedTabsIndex = 1.obs;
  GlobalKey gk1 = GlobalKey();
  GlobalKey gk2 = GlobalKey();
  GlobalKey gk3 = GlobalKey();

  //详情数据
  var pcontent = PcontentItemModel().obs;

  //attr属性筛选
  RxList<PcontentAttrModel> pcontentAttr = <PcontentAttrModel>[].obs;

  //详情 container的位置
  double gk2Position = 0;
  double gk3Position = 0;
  //是否显示详情tab切换
  RxBool showSubHeaderTabs = false.obs;

  //保存筛选属性值
  RxString selectedAttr = "".obs;

  //购买的数量
  RxInt buyNum = 1.obs;

  List subTabsList = [
    {
      "id": 1,
      "title": "商品介绍",
    },
    {"id": 2, "title": "规格参数"},
  ];
  RxInt selectedSubTabsIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
  }

  @override
  void onReady() {
    super.onReady();
  }

//获取元素位置   globalKey.currentContext!.findRenderObject()可以获取渲染的属性。
  getContainerPosition(pixels) {
    RenderBox box2 = gk2.currentContext!.findRenderObject() as RenderBox;
    gk2Position = box2.localToGlobal(Offset.zero).dy +
        pixels -
        (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(120));

    RenderBox box3 = gk3.currentContext!.findRenderObject() as RenderBox;
    gk3Position = box3.localToGlobal(Offset.zero).dy +
        pixels -
        (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(120));
    print(gk2Position);

    print(gk3Position);
  }

  //监听滚动条滚动事件
  void scrollControllerListener() {
    scrollController.addListener(() {
      //获取渲染后的元素的位置
      if (gk2Position == 0 && gk3Position == 0) {
        print(scrollController.position.pixels);
        //获取Container高度的时候获取的是距离顶部的高度，如果要从0开始计算要加下滚动条下拉的高度
        getContainerPosition(scrollController.position.pixels);
      }
      //显示隐藏详情 subHeader tab切换
      if (scrollController.position.pixels > gk2Position &&
          scrollController.position.pixels < gk3Position) {
        if (showSubHeaderTabs.value == false) {
          showSubHeaderTabs.value = true;
          selectedTabsIndex.value = 2;
          update();
        }
      } else if (scrollController.position.pixels > 0 &&
          scrollController.position.pixels < gk2Position) {
        if (showSubHeaderTabs.value == true) {
          showSubHeaderTabs.value = false;
          selectedTabsIndex.value = 1;
          update();
        }
      } else if (scrollController.position.pixels > gk2Position) {
        if (showSubHeaderTabs.value == true) {
          showSubHeaderTabs.value = false;
          selectedTabsIndex.value = 3;
          update();
        }
      }

      //显示隐藏顶部tab切换
      if (scrollController.position.pixels <= 100) {
        opcity.value = scrollController.position.pixels / 100;
        if (opcity.value > 0.96) {
          opcity.value = 1;
        }
        if (showTabs.value == true) {
          showTabs.value = false;
        }
        update();
      } else {
        if (showTabs.value == false) {
          showTabs.value = true;
          update();
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

//改变tab切换
  void changeSelectedTabsIndex(index) {
    selectedTabsIndex.value = index;
    update();
  }

  //改变内容区域的tab切换
  void changeSelectedSubTabsIndex(index) {
    selectedSubTabsIndex.value = index;
    //跳转到指定位置
    scrollController.jumpTo(gk2Position);
    update();
  }

/*   
    把[{cate: 颜色, list: [土豪金, 玫瑰红, 磨砂黑]}, {cate: 内存, list: [16G, 32G, 64G]}]
变成map类型的对象

    [
      {
        cate: 颜色, 
        list: [
          {
            title:土豪金,
            checked:true
          },
          {
            title:玫瑰红,
            checked:false
          },{
            title:磨砂黑,
            checked:false

          }
        ]
      },
      {cate: 内存, 
      list: [
          {
             title:16G,
            checked:true        
          },
           {
             title:32G,
            checked:false        
          }
      ]}

    ]
  */

//初始化attr
  initAttr(List<PcontentAttrModel> attr) {
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list!.length; j++) {
        if (j == 0) {
          attr[i].attrList!.add({"title": attr[i].list![j], "checked": true});
        } else {
          attr[i].attrList!.add({"title": attr[i].list![j], "checked": false});
        }
      }
    }
  }

//改变attr  cate  颜色    title 玫瑰红
  changeAttr(cate, title) {
    for (var i = 0; i < pcontentAttr.length; i++) {
      if (pcontentAttr[i].cate == cate) {
        for (var j = 0; j < pcontentAttr[i].attrList!.length; j++) {
          pcontentAttr[i].attrList![j]["checked"] = false;
          if (pcontentAttr[i].attrList![j]["title"] == title) {
            pcontentAttr[i].attrList![j]["checked"] = true;
          }
        }
      }
    }
    update();
  }

  //获取attr属性
  setSelectedAttr() {
    List tempList = [];
    for (var i = 0; i < pcontentAttr.length; i++) {
      for (var j = 0; j < pcontentAttr[i].attrList!.length; j++) {
        if (pcontentAttr[i].attrList![j]["checked"]) {
          tempList.add(pcontentAttr[i].attrList![j]["title"]);
        }
      }
    }
    selectedAttr.value = tempList.join(",");
    update();
  }

  //增加数量
  incBuyNum() {
    buyNum.value++;
    update();
  }

  //减少数量
  decBuyNum() {
    if (buyNum.value > 1) {
      buyNum.value--;
      update();
    }
  }

  //加入购物车
  void addCart() {
    setSelectedAttr();
    print("加入购物车");
    CartServices.addCart(pcontent.value, selectedAttr.value, buyNum.value);
    //把back放在上面不然不显示
    Get.back();
    Get.snackbar("提示", "加入购物车成功");
  }

//立即购买
  Future<void> buy() async {
    setSelectedAttr();

    print("立即购买");
    Get.back();
    bool loginState = await isLogin();
    if (loginState) {
      //保存商品信息
      List tempList = [];
      tempList.add({
        "_id": pcontent.value.sId,
        "title": pcontent.value.title,
        "price": pcontent.value.price,
        "selectedAttr": selectedAttr.value,
        "count": buyNum.value,
        "pic": pcontent.value.pic,
        "checked": true
      });
      Storage.setData("checkoutList", tempList);
      //执行跳转
      Get.toNamed("/checkout");
    } else {
      //执行跳转
      Get.toNamed("/code-login-step-one");
      Get.snackbar("提示信息!", "您还有没有登录，请先登录");
    }
  }

  //判断用户有没有登录
  Future<bool> isLogin() async {
    return await UserServices.getUserLoginState();
  }

  //获取要结算的商品
}
