// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_guitar/animations/slide_animation.dart';
import 'package:flutter_guitar/guitar_play/presentation/provider/controller_guitar.dart';
import 'package:flutter_guitar/guitar_play/presentation/views/widgets/dropdown_widget.dart';

// import 'package:flutter_guitar/guitar_play/presentation/views/widgets/dropdown_widget.dart';
import 'package:flutter_guitar/guitar_play/presentation/views/widgets/guitar_board%20copy.dart';
import 'package:flutter_guitar/guitar_play/presentation/views/widgets/tabbar_widget.dart';
import 'package:flutter_guitar/utils/app_constants.dart';

// import 'package:flutter_guitar/guitar_play/presentation/views/widgets/guitar_board_uifixed.dart';
// import 'package:flutter_guitar/guitar_play/presentation/views/widgets/guitar_board.dart';
// import 'package:flutter_guitar/guitar_play/presentation/views/widgets/tabbar_widget.dart';
// import 'package:flutter_guitar/utils/app_constants.dart';
import 'package:flutter_guitar/utils/color_constants.dart';
import 'package:flutter_guitar/utils/image_constants.dart';

// import 'package:flutter_guitar/utils/provider_registration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class GuitarPlayScreen extends StatefulWidget {
  const GuitarPlayScreen({super.key});

  @override
  State<GuitarPlayScreen> createState() => _GuitarPlayScreenState();
}

class _GuitarPlayScreenState extends State<GuitarPlayScreen> {
  GuitarController provider = Get.put(GuitarController());

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // final provider = ref.watch(guitarProvider);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      TabBarWidget(),
                      const SizedBox(
                        height: 26,
                      ),
                      DropDownWidget(
                        hintLabel: 'Select category',
                        onChanged: (String? value) {
                          provider.setCategoryValue(value);
                          provider.dropdownCategoryValue.value = value!;
                          // ref.read(guitarProvider).setItem(value);

                          // provider.
                        },
                        items: provider.categories,
                        width: null,
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Obx(
                        () => provider.tabItem.value == 0
                            ? Text(
                                AppConstants.selectTheNotes,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: ColorConstants.white,
                                    ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: DropDownWidget(
                                      hintLabel: 'Select note',
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          provider.setDropdownRootValue(value);
                                        }
                                      },
                                      items: provider.keysList,
                                      width: 85,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: DropDownWidget(
                                      hintLabel: "Select scale",
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          provider
                                              .setDropdownTonalityValue(value);
                                        }
                                      },
                                      items: provider.scales,
                                      width: null,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            const GuitarBoardAlt(),
                            Positioned(
                              child: Obx(
                                () => provider.matchedChords.isNotEmpty
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                          child: Image.asset(
                                            ImageConstants.arrowPrevious,
                                          ),
                                          onTap: () => {
                                            provider.onClickPrevious(),
                                          },
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            Positioned(
                              child: Obx(
                                () => provider.matchedChords.isNotEmpty
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          child: Image.asset(
                                            ImageConstants.arrowNext,
                                          ),
                                          onTap: () => {provider.onClickNext()},
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              provider.refreshLists();
                            },
                            child: Image.asset(ImageConstants.refresh),
                          ),
                          Obx(
                            () => provider.matchFound.value
                                ? SlideAnimation(
                                    mainWidget: Container(
                                      height: 55,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.midGray,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        provider.currentScale.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: ColorConstants.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  )
                                : SlideAnimation(
                                    mainWidget: SizedBox(
                                      height: 55,
                                      width: 130,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await provider.findMatch();
                                          // await provider.giveSuggestion({
                                          //   'p': [4, 6, 6, 5, 4, 4],
                                          //   'f': "134211",
                                          //   'scale': 'Ab',
                                          // }, 0);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              const MaterialStatePropertyAll<
                                                  Color>(
                                            ColorConstants.secondary,
                                          ),
                                          shape: MaterialStatePropertyAll<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                        child: provider.isFinding.value
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                provider.tabItem.value == 0
                                                    ? AppConstants.find
                                                    : AppConstants.explore,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color:
                                                          ColorConstants.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                      ),
                                    ),
                                  ),
                          ),
                          Image.asset(ImageConstants.volume),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
