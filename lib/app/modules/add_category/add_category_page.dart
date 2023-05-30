import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import 'add_category_controller.dart';

class AddCategoryPage extends GetView<AddCategoryController> {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Get.theme.colorScheme;

    return GetBuilder<AddCategoryController>(
      builder: (_) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text('Adicionar categoria')),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: controller.finish,
                    child: const Text('Finalizar'),
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: FixedTimeline.tileBuilder(
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: const Color(0xff989898),
                        indicatorTheme: const IndicatorThemeData(
                          position: 0,
                          size: 20.0,
                        ),
                        connectorTheme: const ConnectorThemeData(
                          thickness: 2.5,
                        ),
                      ),
                      builder: TimelineTileBuilder.connected(
                        itemCount: controller.steps.length,
                        connectionDirection: ConnectionDirection.before,
                        contentsBuilder: (context, index) {
                          final step = controller.steps[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Text(
                                    step.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      step.child,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        connectorBuilder: (context, index, type) {
                          final lastIndex = index - 1 > -1 ? index - 1 : null;

                          return SolidLineConnector(
                            color: lastIndex != null
                                ? controller.steps[lastIndex].isDone()
                                    ? colorScheme.secondary
                                    : colorScheme.onBackground
                                : colorScheme.onBackground,
                          );
                        },
                        indicatorBuilder: (_, index) {
                          final step = controller.steps[index];

                          return DotIndicator(
                            size: 54,
                            color: step.isDone()
                                ? colorScheme.secondary
                                : Colors.transparent,
                            border: Border.all(
                              width: 2,
                              color: step.isDone()
                                  ? colorScheme.secondary
                                  : colorScheme.onBackground,
                            ),
                            child: Icon(
                              step.indicatorIcon,
                              color: step.isDone()
                                  ? colorScheme.onSecondary
                                  : colorScheme.onBackground,
                              size: 18.0,
                            ),
                          );
                        },
                        itemExtent: 130,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: controller.isLoading,
              child: const Scaffold(
                backgroundColor: Colors.black54,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
