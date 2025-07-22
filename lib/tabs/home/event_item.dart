import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  final String imageName;
  final String text;
  const EventItem({super.key, required this.imageName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/$imageName.png",
              height: MediaQuery.sizeOf(context).height * 0.30,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            margin: EdgeInsets.only(top: 8, left: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Themeapp.white,
            ),
            child: Column(
              children: [
                Text("21", style: Theme.of(context).textTheme.titleLarge),
                Text(
                  "Nov",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Themeapp.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Themeapp.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Themeapp.black,
                      ),
                    ),
                  ),
                  Icon(Icons.favorite, color: Themeapp.primary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
