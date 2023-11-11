// import 'package:flutter/material.dart';
// import 'package:flutter_guitar/guitar_play/presentation/provider/guitar_provider.dart';
// import 'package:flutter_guitar/utils/color_constants.dart';
// import 'package:flutter_guitar/utils/provider_registration.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class GuitarBoard extends StatefulWidget {
//   const GuitarBoard({super.key});

//   @override
//   State<GuitarBoard> createState() => _GuitarBoardState();
// }

// class _GuitarBoardState extends State<GuitarBoard> {
//   late GuitarProvider provider;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         provider = ref.watch(guitarProvider);

//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 50),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 220,
//                 // height: double.infinity,
//                 alignment: Alignment.center,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     Column(
//                       children: [
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Expanded(
//                           child: Container(
//                             // height: double.infinity,
//                             width: 200,
//                             color: ColorConstants.lightSecondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                     ListView.separated(
//                       shrinkWrap: true,
//                       padding: EdgeInsets.zero,
//                       physics: const NeverScrollableScrollPhysics(),
//                       separatorBuilder: (context, pos) {
//                         return rowDivider();
//                       },
//                       itemBuilder: (context, pos) {
//                         final itemList = provider.itemsList[pos];
//                         return Stack(
//                           children: [
//                             SizedBox(
//                               height: 55,
//                               child: ListView.separated(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 scrollDirection: Axis.horizontal,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 separatorBuilder: (context, index) {
//                                   return columnDivider(
//                                     pos,
//                                     index,
//                                     7,
//                                   );
//                                 },
//                                 itemBuilder: (context, index) {
//                                   if (index < itemList.length - 1) {
//                                     final item = provider.itemsList[pos][index];
//                                     return Stack(
//                                       alignment: Alignment.center,
//                                       children: [
//                                         SizedBox(
//                                           width: index == 0 ? 15 : 30,
//                                           height: 55,
//                                         ),
//                                         if (item.hasDark)
//                                           Container(
//                                             width: 12,
//                                             height: 12,
//                                             decoration: const BoxDecoration(
//                                               color: ColorConstants.primary,
//                                               // color: Colors.amber,
//                                               shape: BoxShape.circle,
//                                             ),
//                                           )
//                                       ],
//                                     );
//                                   }

//                                   return SizedBox(
//                                     width: index == 0 ? 15 : 30,
//                                     height: 55,
//                                   );
//                                 },
//                                 itemCount: itemList.length + 1,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 55,
//                               child: ListView.separated(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 scrollDirection: Axis.horizontal,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 separatorBuilder: (context, index) {
//                                   return dotDivider(pos, index, 7);
//                                 },
//                                 itemBuilder: (context, index) {
//                                   return const SizedBox();
//                                 },
//                                 itemCount: itemList.length + 1,
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                       itemCount: provider.itemsList.length,
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 // height: double.infinity,
//                 width: 20,
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   padding: EdgeInsets.zero,
//                   // physics: AlwaysScrollableScrollPhysics(),
//                   physics: const NeverScrollableScrollPhysics(),
//                   separatorBuilder: (context, pos) {
//                     return SizedBox(
//                       height: pos == 0 ? 20 : 35,
//                     );
//                   },
//                   itemBuilder: (context, pos) {
//                     return Text(
//                       '$pos',
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                             color: ColorConstants.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                             height: 1.2,
//                           ),
//                     );
//                   },
//                   itemCount: provider.itemsList.length,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget rowDivider() {
//     return Container(
//       height: 2,
//       color: ColorConstants.primary,
//     );
//   }

//   Widget columnDivider(int pos, int index, int length, {bool hasColor = true}) {
//     return Stack(
//       alignment: pos == 0 ? Alignment.topCenter : Alignment.center,
//       children: [
//         SizedBox(
//           height: 55,
//           child: Container(
//             width: (length - index) * 0.6,
//             height: 55,
//             color: ColorConstants.gray,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget dotDivider(int pos, int index, int length, {bool hasColor = true}) {
//     final item = provider.itemsList[pos][index];
//     return Stack(
//       alignment: pos == 0 ? Alignment.topCenter : Alignment.center,
//       children: [
//         // upper layer of string to place notes marker
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           height: 55,
//           child: Container(
//             width: (length - index) * 0.6,
//             height: 55,
//             color: Colors.transparent,
//           ),
//         ),
//         if (item.dot != null)
//           Container(
//             width: 20,
//             height: 20,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               // An “X” above a string indicates that the string should be muted
//               // when strumming a chord.
//               // An “O” above a string means that the string should be played in
//               // the open position (without a finger on any of the frets aligned
//               // with that string) in a given chord.

//               color: item.dot == 'o'
//                   ? ColorConstants.secondary
//                   : ColorConstants.gray,
//             ),
//           )
//       ],
//     );
//   }
// }
