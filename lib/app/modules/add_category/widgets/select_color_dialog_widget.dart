import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectColorDialogWidget extends StatefulWidget {
  const SelectColorDialogWidget({Key? key}) : super(key: key);

  @override
  State<SelectColorDialogWidget> createState() =>
      _SelectColorDialogWidgetState();
}

class _SelectColorDialogWidgetState extends State<SelectColorDialogWidget> {
  List<Color> colors = [
    Colors.blue,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.red,
    Colors.redAccent,
    Colors.orange,
    Colors.deepOrange,
    Colors.purple,
    Colors.deepPurple,
    Colors.green,
    Colors.lightGreen,
    Colors.yellow,
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
              'Escolha uma cor',
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
              children: colors
                  .map((e) => GestureDetector(
                        onTap: () {
                          Get.back(result: e);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: e,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
