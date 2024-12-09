import 'package:flutter/material.dart';

import '../units/screenAdapter.dart';

class UserAgreement extends StatelessWidget {
  const UserAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Checkbox(activeColor: Colors.orange, value: true, onChanged: (v) {}),
          const Text("我已阅读并同意"),
          const Text(
            "《用户协议》",
            style: TextStyle(color: Colors.orange),
          ),
          const Text("《隐私协议》", style: TextStyle(color: Colors.orange)),
        ],
      ),
    );
  }
}
