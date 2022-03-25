import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildBottomNavigationBar() {
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xFF51795e),
    ),
    height: 50,
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