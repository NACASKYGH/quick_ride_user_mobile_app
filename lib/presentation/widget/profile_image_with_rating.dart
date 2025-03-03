import 'image_loader.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:x_ride_user/utils/app_colors.dart';

class ProfileImageWithRating extends StatelessWidget {
  const ProfileImageWithRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
          ),
          child: ImageLoader(
            height: 90,
            width: 90,
            radius: 90,
            imageUrl: 'https://d1flfk77wl2xk4.cloudfront.'
                'net/Assets/00/814/l_p0122481400.jpg',
          ),
        ),
        Container(
          height: 32,
          width: 90,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(90),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: AppColors.blackText,
                size: 20,
              ),
              const Gap(6),
              Text(
                '4.4',
                style: context.textTheme.headlineMedium?.copyWith(
                  color: AppColors.blackText,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
