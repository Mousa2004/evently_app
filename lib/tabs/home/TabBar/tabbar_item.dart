import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabbarItem extends StatelessWidget {
  final String text;
  final String imageIcon;
  final bool isSelect;
  final Color selectColor;
  final Color unselectColor;
  final Color? selectBackgroundColor;
  final Color? colorBorder;
  const TabbarItem({
    super.key,

    required this.text,
    required this.imageIcon,
    required this.isSelect,
    required this.selectColor,
    required this.unselectColor,
    this.colorBorder,
    this.selectBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorBorder ?? Themeapp.white),
        borderRadius: BorderRadius.circular(46),
        color: isSelect
            ? (selectBackgroundColor ?? Themeapp.white)
            : Themeapp.transparent,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/$imageIcon.svg",
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
