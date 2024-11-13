import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youapp/app/constants/app_icon.dart';
import 'package:youapp/app/styles/app_color.dart';

class SectionEdit extends StatelessWidget {
  final String title;
  final Widget? action;
  final Widget child;
  final Function()? onTap;

  const SectionEdit({
    super.key,
    required this.title,
    this.action,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color.lerp(AppColor.primary, Colors.white, 0.025),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              child,
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 2,
          child: action ??
              IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  AppIcon.edit,
                  fit: BoxFit.cover,
                ),
              ),
        ),
      ],
    );
  }
}
