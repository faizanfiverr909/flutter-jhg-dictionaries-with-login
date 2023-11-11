import 'package:flutter/material.dart';
import 'package:flutter_guitar/utils/color_constants.dart';
import 'package:flutter_guitar/utils/image_constants.dart';
import 'package:flutter_guitar/widgets/dropdown2_widget.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    required this.items,
    required this.onChanged,
    required this.width,
    required this.hintLabel,
    this.isExpanded = true,
    // required this.selectedValue,
    super.key,
  });

  final List<String> items;
  // final String? selectedValue;
  final String hintLabel;
  final ValueChanged<String?>? onChanged;
  final bool isExpanded;
  final double? width;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  ValueNotifier<String?> selectedValue = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedValue,
      builder: (context, String? value, child) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: widget.isExpanded,
            hint: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.hintLabel,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: widget.items
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            value: value,
            onChanged: (String? value) {
              if(value!=null) {
                selectedValue.value = value;
                widget.onChanged?.call(value);
              }
            },
            buttonStyleData: ButtonStyleData(
              height: 55,
              width: widget.width,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: ColorConstants.midGray,
              ),
              elevation: 2,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: ColorConstants.midGray,
              ),
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Image.asset(
                ImageConstants.downArrow,
              ),
              openMenuIcon: Image.asset(
                ImageConstants.downArrow,
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        );
      },
    );
  }
}
