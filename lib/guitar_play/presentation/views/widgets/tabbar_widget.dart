import 'package:flutter/material.dart';
import 'package:flutter_guitar/guitar_play/presentation/provider/controller_guitar.dart';
import 'package:flutter_guitar/guitar_play/presentation/views/widgets/tabbar_chip.dart';
import 'package:flutter_guitar/utils/app_constants.dart';
// import 'package:flutter_guitar/utils/provider_registration.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TabBarWidget extends StatelessWidget {
  TabBarWidget({super.key});
  final GuitarController provider = Get.put(GuitarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // ref.read(guitarProvider).setTabItem(0);
                provider.setTabItem(0);
              },
              child: TabBarChip(
                name: AppConstants.identify,
                isSelected: provider.tabItem.value == 0,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                // ref.read(guitarProvider).setTabItem(1);
                provider.setTabItem(1);
              },
              child: TabBarChip(
                name: AppConstants.explore,
                isSelected: provider.tabItem.value == 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
