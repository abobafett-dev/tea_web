import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tea_web/additionalThings/projectColors.dart';

Widget buildBottomNavigationBar() {
  return Container(
    decoration: const BoxDecoration(
      color: Color(secondColor),
    ),
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home_outlined,
              size: 40,
            )),
      ],
    ),
  );
}