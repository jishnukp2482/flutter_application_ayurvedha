import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_ayurvedha/src/feature/presentation/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelWithDropDownField<T> extends StatelessWidget {
  LabelWithDropDownField({
    super.key,
    required this.textDropDownLabel,
    this.hintText,
    this.labelText,
    this.onChanged,
    required this.items,
    this.icon,
    this.showSelectedItems = true,
    this.itemAsString,
    this.alignLabelWithHint,
    this.isOptional = false,
    this.isHintvalue = false,
    this.onBeforePopupOpening,
    this.selectedItem,
    this.showSearchBox = false,
    this.inputFormatters,
    this.onSubmitted,
    this.onSearchChanged,
    this.enabled = true,
    this.readOnly = false,
    this.labelStyle,
    this.hintStyle,
  });
  final String textDropDownLabel;
  final String? hintText;
  final String? labelText;
  final List<T> items;
  final ValueChanged<T>? onChanged;
  final bool? alignLabelWithHint;
  final Widget? icon;
  final bool showSelectedItems;
  final String Function(T)? itemAsString;
  final bool? isOptional;
  final bool? isHintvalue;
  Future<bool?> Function(T?)? onBeforePopupOpening;
  final T? selectedItem;
  final bool showSearchBox;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onSubmitted;
  final void Function(String)? onSearchChanged;
  final bool enabled;
  final bool readOnly;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                textDropDownLabel,
                style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              isOptional == true
                  ? Text(
                      "*",
                      style: GoogleFonts.poppins(
                        color: AppColors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.1),
              //     spreadRadius: 1,
              //     blurRadius: 7,
              //     offset: const Offset(0, 6),
              //   ),
              // ],
            ),
            width: w,
            child: DropdownSearch<T>(
              enabled: enabled,
              compareFn: (item1, item2) => true,
              onBeforePopupOpening: onBeforePopupOpening,
              selectedItem: selectedItem,

              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                constraints: BoxConstraints(),
                scrollbarProps: const ScrollbarProps(thumbVisibility: true),
                showSelectedItems: showSelectedItems,
                showSearchBox: showSearchBox,
                listViewProps: const ListViewProps(padding: EdgeInsets.zero),

                containerBuilder: (context, popupWidget) {
                  return SafeArea(child: popupWidget);
                },

                searchFieldProps: TextFieldProps(
                  readOnly: readOnly,
                  style: GoogleFonts.poppins(
                    color: AppColors.black,
                    fontSize: 11.sp,
                  ),
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    hintText: hintText ?? "",
                    hintStyle:
                        hintStyle ??
                        GoogleFonts.poppins(
                          color: AppColors.grey,
                          fontSize: 14.sp,
                        ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  onSubmitted: onSubmitted,
                  onChanged: onSearchChanged,
                ),
              ),

              items: (filter, loadProps) => items,
              itemAsString: itemAsString,
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  alignLabelWithHint: alignLabelWithHint,
                  icon: icon,
                  fillColor: AppColors.grey.withOpacity(0.2),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: AppColors.greyText,
                      width: 0.3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColors.white, width: 0.3),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: AppColors.greyText,
                      width: 0.1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  hintText: hintText ?? "",
                  // hintStyle: GoogleFonts.poppins(
                  //   color: AppColors.grey,
                  //   fontSize: 14,
                  // ),
                  hintStyle: GoogleFonts.poppins(
                    color: isHintvalue == true ? Colors.black : Colors.black,
                    fontSize: 14,
                  ),
                  labelText: labelText ?? "",
                  labelStyle:
                      labelStyle ??
                      GoogleFonts.poppins(
                        color: AppColors.grey,
                        fontSize: 14.sp,
                      ),
                ),
              ),
              onChanged: (value) {
                if (value != null && onChanged != null) {
                  onChanged!(value); // ✅ Safe call after checking null
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
