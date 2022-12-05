import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElegantButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? onColor;
  final VoidCallback? onTap;
  const ElegantButton({
    Key? key,
    required this.text,
    this.color,
    this.onColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 50,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            height: 40,
            color: onColor ?? Get.theme.colorScheme.onPrimary,
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 10),
            child: Material(
              color: color ?? Get.theme.colorScheme.primary,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width,
                  height: 40,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: onColor ?? Get.theme.colorScheme.onPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
