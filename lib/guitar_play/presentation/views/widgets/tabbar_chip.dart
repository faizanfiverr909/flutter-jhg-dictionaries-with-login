import 'package:flutter/material.dart';
import 'package:flutter_guitar/utils/color_constants.dart';

class TabBarChip extends StatelessWidget {
  const TabBarChip({required this.name, required this.isSelected, super.key});

  final String name;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? ColorConstants.gray : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorConstants.gray,
          width: 2,
        ),
      ),
      child: Text(
        name,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ColorConstants.white),
      ),
    );
  }
}
