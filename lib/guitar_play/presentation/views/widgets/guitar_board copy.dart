import 'package:flutter/material.dart';
import 'package:flutter_guitar/guitar_play/presentation/provider/controller_guitar.dart';
import 'package:flutter_guitar/utils/color_constants.dart';
import 'package:get/get.dart';

class GuitarBoardAlt extends StatefulWidget {
  const GuitarBoardAlt({super.key});

  @override
  State<GuitarBoardAlt> createState() => _GuitarBoardAltState();
}

class _GuitarBoardAltState extends State<GuitarBoardAlt> {
  GuitarController provider = Get.find<GuitarController>();
  // late GuitarProvider provider;
  Future<void> loadFullList() async {
    await provider.fetchDefaultLists();
    await provider.fetchScalesList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFullList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 220,
                  // height: double.infinity,
                  constraints: const BoxConstraints(maxHeight: 850),
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Container(
                              // height: double.infinity,
                              width: 180,
                              color: ColorConstants.lightSecondary,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Obx(
                          () => ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, pos) {
                              return rowDivider();
                            },
                            itemBuilder: (context, pos) {
                              final itemList = provider.itemsList[pos];
                              return Stack(
                                children: [
                                  SizedBox(
                                    height: 55,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) {
                                        return columnDivider(
                                          pos,
                                          index,
                                          7,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        if (index < itemList.length - 1) {
                                          final item =
                                              provider.itemsList[pos][index];
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                // color: Colors.amberAccent,
                                                width: index == 0
                                                    ? 15
                                                    : index == 1 && pos == 11
                                                        ? 25.5
                                                        : index == 2 &&
                                                                pos == 11
                                                            ? 27
                                                            : index == 3 &&
                                                                    pos == 11
                                                                ? 30
                                                                : index == 4 &&
                                                                        pos ==
                                                                            11
                                                                    ? 24
                                                                    : index == 5 &&
                                                                            pos ==
                                                                                11
                                                                        ? 25
                                                                        : 30,
                                                height: 55,
                                              ),
                                              if (item.hasDark!.value)
                                                Container(
                                                  width: 12,
                                                  height: 12,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        ColorConstants.primary,
                                                    // color: Colors.amber,
                                                    shape: BoxShape.circle,
                                                  ),
                                                )
                                            ],
                                          );
                                        }

                                        return Container(
                                          // color: Colors.amber,
                                          width: index == 0
                                              ? 24
                                              : index == 5 && pos == 11
                                                  ? 27
                                                  : index == 6 && pos == 11
                                                      ? 25
                                                      : 32,
                                          height: 55,
                                        );
                                      },
                                      itemCount: itemList.length + 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 55,
                                    child: Row(
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) {
                                            return dotDivider(pos, index, 7);
                                          },
                                          itemBuilder: (context, index) {
                                            return const SizedBox();
                                          },
                                          itemCount: itemList.length + 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: provider.itemsList.length,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  // height: double.infinity,
                  // height: 850,
                  width: 20,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    // physics: AlwaysScrollableScrollPhysics(),
                    physics: const NeverScrollableScrollPhysics(),
                    // separatorBuilder: (context, pos) {
                    //   return SizedBox(
                    //       // height: pos == 0 ? 20 : 35,
                    //       height: 45);
                    // },
                    itemBuilder: (context, pos) {
                      // print("pos>>> $pos");
                      return Column(
                        children: [
                          pos == 0
                              ? Text(
                                  '0',
                                  // textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: ColorConstants.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        height: 1.2,
                                      ),
                                )
                              : SizedBox.shrink(),
                          pos == 0
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox.shrink(),
                          Container(
                            height: pos == 0 ? 47 : 57,
                            // color: pos.isEven ? Colors.amber : Colors.green,
                            // alignment: Alignment.bottomCenter,
                            child: Text(
                              '${pos + 1}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: ColorConstants.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    height: 1.2,
                                  ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: provider.itemsList.length,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rowDivider() {
    return Container(
      height: 2,
      color: ColorConstants.primary,
    );
  }

  Widget columnDivider(int pos, int index, int length, {bool hasColor = true}) {
    return Stack(
      // alignment: pos == 0 ? Alignment.topCenter : Alignment.center,
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        // SizedBox(
        //   height: 55,
        //   child:
        if (index == 1 && pos == 11 || index == 4 && pos == 11)
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: ColorConstants.primary,
              // color: Colors.amber,
              shape: BoxShape.circle,
            ),
          ),
        Container(
          width: (length - index) * 0.6,
          height: 55,
          color: ColorConstants.gray,
        ),
        // ),
      ],
    );
  }

  Widget dotDivider(int pos, int index, int length, {bool hasColor = true}) {
    final item = provider.itemsList[pos][index];
    return Stack(
      alignment: pos == 0 ? Alignment.topCenter : Alignment.center,
      children: [
        // upper layer of string to place notes marker
        InkWell(
          onTap: () async {
            await provider.addNotes(index: index, pos: pos);
            await provider.addToFind(
              pos == 0 ? pos : pos + 1,
              index,
            );
            provider.itemsList.refresh();
            provider.toFindList.refresh();
            provider.activeStringList.refresh();
            // if (provider.itemsList[pos][index].dot != 'o'.obs) {
            //   provider.itemsList[pos][index].dot = 'o'.obs;
            // } else {
            //   provider.itemsList[pos][index].dot = ''.obs;
            // }
            // setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 55,
            child: Container(
              width: (length - index) * 0.6,
              height: 55,
              color: Colors.transparent,
            ),
          ),
        ),
        if (item.dot != ''.obs)
          Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,

              // color: item.dot == 'o'.obs && pos != 0
              //     ? ColorConstants.secondary
              //     : ColorConstants.gray,
              color:
                  // item.dot == 'o'.obs
                  //     ? ColorConstants.secondary
                  //     :
                  ColorConstants.gray,
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
