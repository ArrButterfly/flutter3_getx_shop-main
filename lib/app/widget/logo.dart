import 'package:flutter/material.dart';

import '../units/screenAdapter.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(80),
      child: SizedBox(
        width: 120,
        height: 120,
        child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
      ),
    );
  }
}
