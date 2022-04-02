import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tea_web/additionalThings/projectColors.dart';
import 'package:tea_web/main.dart';

Widget buildBottomNavigationBar(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      color: Color(secondColor),
    ),
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(context, mainPage.getRoute());
            },
            icon: const Icon(
              Icons.home_outlined,
              size: 40,
            )),
      ],
    ),
  );
}