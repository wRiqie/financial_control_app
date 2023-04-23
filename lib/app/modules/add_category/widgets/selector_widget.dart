import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectorWidget extends StatelessWidget {
  final Widget prefixWidget;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SelectorWidget({
    Key? key,
    required this.prefixWidget,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          prefixWidget,
          const SizedBox(
            width: 18,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 18,
          ),
          const Icon(
            Icons.swap_vert,
          ),
        ],
      ),
    );
  }
}
