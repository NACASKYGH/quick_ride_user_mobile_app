import 'package:gap/gap.dart';
import '../../utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:searchfield/searchfield.dart';
import 'package:quick_ride_mobile_app/utils/extensions.dart';

class AppSearchSelection extends StatefulWidget {
  const AppSearchSelection({
    super.key,
    required this.selectionList,
    required this.onSuggestionTap,
    this.initialValue,
    this.hintText = '',
    this.label,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixWidget,
    this.controller,
    this.radius = 8,
    this.borderColor,
    this.bgColor,
    this.textColor,
    this.textInputAction,
    this.prefixIconColor,
    this.labelStyle,
    this.labelSpace = 8,
    this.disabled = false,
    this.onPrefixTap,
    this.suffixWidget,
    this.contentPadding,
    this.textStyle,
    this.errorStyle,
    this.hintStyle,
    this.focusBorder,
    this.onTap,
  });

  final List<String> selectionList;
  final Function(SearchFieldListItem<String>) onSuggestionTap;
  final String? initialValue;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

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
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final OutlineInputBorder? focusBorder;
  final Function()? onTap;
  @override
  State<AppSearchSelection> createState() => _AppSearchSelectionState();
}

class _AppSearchSelectionState extends State<AppSearchSelection> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController localController = TextEditingController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      localController.text = widget.initialValue ?? '';
      widget.controller?.text = widget.initialValue ?? '';
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
            style:
                widget.labelStyle ??
                context.textTheme.labelMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Gap(widget.labelSpace),
        ],
        SearchField(
          suggestions:
              widget.selectionList
                  .map(
                    (item) => SearchFieldListItem(
                      item,
                      item: item,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelMedium,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          itemHeight: 57,
          focusNode: _focusNode,
          enabled: !widget.disabled,
          controller: widget.controller ?? localController,
          textInputAction: widget.textInputAction,
          onTap: widget.onTap,
          validator: widget.validator,
          onSuggestionTap: (e) {
            _focusNode.unfocus();
            widget.onSuggestionTap(e);
          },
          onTapOutside: (_) => _focusNode.unfocus(),
          emptyWidget: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                'No results',
                style: context.textTheme.labelMedium?.copyWith(fontSize: 12),
              ),
            ),
          ),
          searchInputDecoration: SearchInputDecoration(
            filled: widget.bgColor != null,
            fillColor: widget.bgColor,
            prefixIcon: widget.prefixWidget,
            suffixIcon: widget.suffixWidget,
            border: basedBorder,
            focusedBorder: widget.focusBorder ?? basedBorder,
            enabledBorder: basedBorder,
            errorBorder: basedBorder,
            focusedErrorBorder: basedBorder,
            errorStyle: widget.errorStyle,
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                context.textTheme.headlineMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey1,
                ),

            searchStyle:
                widget.textStyle ??
                context.textTheme.headlineMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: widget.textColor,
                ),
          ),
        ),
      ],
    );
  }
}
