import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_colors.dart';

class CustomDropDownField<T> extends StatelessWidget {
  const CustomDropDownField({
    super.key,
    this.textDropDownLabel,
    this.hintText,
    this.labelText,
    this.onChanged,
    required this.items,
    this.icon,
    this.showSelectedItems = true,
    this.itemAsString,
    this.alignLabelWithHint,
    this.compareFn,
    this.isShadow = true,
  });

  final String? textDropDownLabel;
  final String? hintText;
  final String? labelText;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final bool? alignLabelWithHint;
  final Widget? icon;
  final bool showSelectedItems;
  final String Function(T)? itemAsString;
  final bool Function(T, T)? compareFn;
  final bool? isShadow;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          shape: isShadow == true ? BoxShape.rectangle : BoxShape.circle,
          boxShadow:
              isShadow == true
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 6),
                    ),
                  ]
                  : [],
        ),
        width: w,
        child: DropdownSearch<T>(
          compareFn: compareFn ?? (T a, T b) => a == b,
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSelectedItems: showSelectedItems,
          ),
          items: (filter, loadProps) => items,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              alignLabelWithHint: alignLabelWithHint,
              icon: icon,
              fillColor: AppColors.white,
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyText, width: 0.3),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyText, width: 0.3),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              disabledBorder: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(15),
              hintText: hintText ?? "",
              hintStyle: GoogleFonts.poppins(
                color: AppColors.grey,
                fontSize: 14,
              ),
              labelText: labelText ?? "",
              labelStyle: GoogleFonts.poppins(
                color: AppColors.grey,
                fontSize: 14,
              ),
            ),
          ),
          onChanged: onChanged,
          itemAsString: itemAsString,
        ),
      ),
    );
  }
}
