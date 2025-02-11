import 'package:flutter/material.dart';
import '../units/screenAdapter.dart';

class PassTextFiled extends StatelessWidget {
  final bool isPassWord;
  final String hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller; //这是为了获取手机号
  const PassTextFiled(
      {super.key,
      this.controller,
      required this.hintText,
      this.onChanged,
      this.isPassWord = false,
      this.keyboardType = TextInputType.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        // autofocus: true,
        controller: controller,
        obscureText: isPassWord,
        style: TextStyle(fontSize: 18),
        keyboardType: keyboardType, //默认弹出数字键盘
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none //去掉下划线
                ),
        onChanged: onChanged,
      ),
    );
  }
}
