import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabbarItem extends StatelessWidget {
  final String imageName;
  final String text;
  final bool isSelect;
  final Color selectColor;
  final Color unselectColor;
  const TabbarItem({
    super.key,
    required this.imageName,
    required this.text,
    required this.isSelect,
    required this.selectColor,
    required this.unselectColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Themeapp.white),
        borderRadius: BorderRadius.circular(46),
        color: isSelect ? Themeapp.white : Themeapp.transparent,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/$imageName.svg",
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              isSelect ? selectColor : unselectColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: isSelect ? selectColor : unselectColor,
            ),
          ),
        ],
      ),
    );
  }
}
