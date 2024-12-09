import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../units/userServices.dart'; // 确保导入 UserServices

class HttpsMmwClient {
  static String domain = "https://test.qqian.xyz/v0/";
  static Dio dio = Dio();

  HttpsMmwClient() {
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = 5000; // 5s
    dio.options.receiveTimeout = 5000;

    // 初始化时设置 JWT Token
    _setJwtToken();
  }

  // 设置 JWT Token
  Future<void> _setJwtToken() async {
    var tempList = await UserServices.getUserInfo();
    if (tempList.isNotEmpty) {
      String token = tempList[0]['token'];
      print("查询token 信息>>>>>>>>>>>>");
      print(token);
      dio.options.headers['Jwt_token'] = token; // 设置请求头
    }
  }

  // 检查响应状态是登录否过期
  void _checkResponse(Response response) {
    print("请求检查————————————————————————————————>>>>>>");
    print(response.data);
    if (response.data['code'] == 4001) {
      Get.snackbar("提示信息", "账户已过期，请重新登录");
      Get.toNamed("/code-login-step-one");
    }
  }

  Future<dynamic> get(String apiUrl) async {
    await _setJwtToken(); // 确保每次请求前更新 Token
    try {
      var response = await dio.get(apiUrl);
      _checkResponse(response); // 检查响应
      return response;
    } catch (e) {
      print("请求超时: $e");
      return null;
    }
  }

  // PUT 请求方法
  Future<dynamic> put(String apiUrl, {Map? data}) async {
    await _setJwtToken(); // 确保每次请求前更新 Token
    try {
      var response = await dio.put(apiUrl, data: data);
      _checkResponse(response); // 检查响应
      return response;
    } catch (e) {
      print("请求超时: $e");
      return null;
    }
  }

  Future<dynamic> post(String apiUrl, {Map? data}) async {
    await _setJwtToken(); // 确保每次请求前更新 Token
    try {
      var response = await dio.post(apiUrl, data: data);
      _checkResponse(response); // 检查响应
      return response;
    } catch (e) {
      print("请求超时: $e");
      return null;
    }
  }

  // 加载网络图片
  static String replaceUri(String picUrl) {
    String tempUrl = domain + picUrl;
    return tempUrl.replaceAll("\\", "/");
  }
}
