import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectIconDialogWidget extends StatefulWidget {
  final Color? color;
  const SelectIconDialogWidget({Key? key, this.color}) : super(key: key);

  @override
  State<SelectIconDialogWidget> createState() => _SelectIconDialogWidgetState();
}

class _SelectIconDialogWidgetState extends State<SelectIconDialogWidget> {
  List<IconData> icons = [
    Icons.search,
    Icons.home,
    Icons.favorite,
    Icons.star,
    Icons.refresh,
    Icons.book,
    Icons.inventory_2,
    Icons.shop,
    Icons.shopping_bag,
    Icons.shopping_cart,
    Icons.terminal,
    Icons.browse_gallery,
    Icons.rocket_launch,
    Icons.mood,
    Icons.pets,
    Icons.psychology,
    Icons.cookie,
    Icons.bedtime,
    Icons.emoji_flags,
    Icons.cloud,
    Icons.tornado,
    Icons.medical_information,
    Icons.fastfood,
    Icons.games,
    Icons.person,
    Icons.healing,
    Icons.credit_card,
    Icons.show_chart,
    Icons.sports_football,
    Icons.ballot,
    Icons.brush,
    Icons.payments,
    Icons.work,
    Icons.pin,
    Icons.set_meal,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Get.theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Escolha um ícone',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: icons
                  .map((e) => GestureDetector(
                      onTap: () {
                        Get.back(result: e);
                      },
                      child: Icon(
                        e,
                        size: 46,
                        color: widget.color ?? Get.theme.colorScheme.onSurface,
                      )))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
