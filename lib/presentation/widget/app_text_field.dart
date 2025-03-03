import '/utils/extensions.dart';
import '/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.obscuringCharacter = '•',
    this.initialValue,
    this.hintText = '',
    this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.prefixWidget,
    this.controller,
    this.radius = 8,
    this.borderColor,
    this.bgColor,
    this.textColor,
    this.textInputAction,
    this.onSubmitted,
    this.prefixIconColor,
    this.labelStyle,
    this.labelSpace = 8,
    this.disabled = false,
    this.onPrefixTap,
    this.suffixWidget,
    this.maxLines = 1,
    this.minLines = 1,
    this.contentPadding,
    this.textStyle,
    this.errorStyle,
    this.hintStyle,
    this.focusBorder,
    this.onTap,
  });
  final String? initialValue;

  final String hintText;
  final bool obscureText;
  final String obscuringCharacter;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  final TextEditingController? controller;
  final double radius;
  final Color? borderColor;
  final Color? bgColor;
  final Color? textColor;
  final Color? prefixIconColor;
  final TextInputAction? textInputAction;

  final String? label;
  final TextStyle? labelStyle;
  final double labelSpace;
  final bool disabled;
  final Function()? onPrefixTap;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final int maxLines;
  final int minLines;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final OutlineInputBorder? focusBorder;
  final Function()? onTap;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController localController = TextEditingController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      localController.text = widget.initialValue ?? '';
      widget.controller?.text = widget.initialValue ?? '';
      if (widget.initialValue != null) {
        widget.onChanged?.call(widget.initialValue ?? '');
      }
    });
  }

  late OutlineInputBorder basedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.radius),
    borderSide: BorderSide(
      color: widget.borderColor ?? AppColors.grey.withValues(alpha: .7),
    ),
  );

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
          SizedBox(
            height: widget.labelSpace,
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          child: TextFormField(
            enabled: !widget.disabled,
            controller: widget.controller ?? localController,
            obscureText: widget.obscureText,
            obscuringCharacter: widget.obscuringCharacter,
            textInputAction: widget.textInputAction,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            onTap: widget.onTap,
            style: widget.textStyle ??
                context.textTheme.headlineMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: widget.textColor,
                ),
            onFieldSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              prefixIcon: widget.prefixWidget,
              suffixIcon: widget.suffixWidget,
              border: basedBorder,
              focusedBorder: widget.focusBorder ?? basedBorder,
              enabledBorder: basedBorder,
              errorBorder: basedBorder,
              focusedErrorBorder: basedBorder,
              errorStyle: widget.errorStyle,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  context.textTheme.headlineMedium?.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey1,
                  ),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
