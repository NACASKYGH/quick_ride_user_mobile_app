import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import '../../utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppDropDown extends StatefulWidget {
  const AppDropDown({
    super.key,
    this.label,
    this.initialValue,
    this.onChanged,
    this.radius = 8,
    this.borderColor,
    this.bgColor,
    this.textColor,
    this.height = 45,
    this.labelStyle,
    this.labelSpace = 8,
    this.disabled = false,
    this.hintText = 'Choose...',
    required this.dropdownList,
  });

  final Function(String?)? onChanged;
  final String? initialValue;
  final double radius;
  final Color? borderColor;
  final Color? bgColor;
  final Color? textColor;
  final double height;
  final String? label;
  final TextStyle? labelStyle;
  final double labelSpace;
  final bool disabled;
  final String hintText;
  final List<String> dropdownList;

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      selectedValue = widget.initialValue;
      if ((widget.initialValue ?? '').isNotEmpty) {
        widget.onChanged?.call(widget.initialValue);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label ?? '',
            style: widget.labelStyle ??
                context.textTheme.labelMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Gap(widget.labelSpace),
        ],
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: widget.bgColor ?? Colors.transparent,
            border: Border.all(
              color: widget.borderColor ?? AppColors.grey,
            ),
          ),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(widget.radius),
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                selectedValue ?? widget.hintText,
                style: selectedValue == null
                    ? context.textTheme.headlineMedium?.copyWith(
                        fontSize: 15.2,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF777777),
                      )
                    : context.textTheme.headlineMedium?.copyWith(
                        fontSize: 15.2,
                        fontWeight: FontWeight.w500,
                        color: widget.textColor,
                      ),
              ),
            ),
            value: selectedValue,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            icon: const Padding(
              padding: EdgeInsets.only(right: 6.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF666666),
              ),
            ),
            items: widget.dropdownList.map(
              (String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      gender,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontSize: 15.2,
                        fontWeight: FontWeight.w500,
                        color: widget.textColor,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: (value) {
              widget.onChanged?.call(value);
              setState(() => selectedValue = value);
            },
          ),
        ),
      ],
    );
  }
}
