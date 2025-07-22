import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.23,
      decoration: BoxDecoration(
        color: Themeapp.primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(
                "assets/images/profile_logo.png",
                height: MediaQuery.sizeOf(context).height * 0.13,
              ),
              SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Safwat",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "johnsafwat.route@gmail.com",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: Themeapp.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
