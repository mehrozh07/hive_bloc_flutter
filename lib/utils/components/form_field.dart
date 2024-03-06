import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tericce_animation/utils/text_styles/text_styles.dart';

class CustomFormField extends StatelessWidget {
  final Widget? suffixIcon, prefixIcon;
  final String? labelText, hintText, errorText;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final Function(dynamic)? onChange;
  final Function(dynamic)? onFieldSubmitted;
  final Function()? onPressed;
  final TextEditingController? controller;
  final bool obscureText,readOnly,enable,autoFocus;
  final FormFieldValidator? validator;
  final int? maxLength,maxLines;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;
  final bool showHintRight;
  final String? counterText;

  const CustomFormField(
      {super.key,
      this.suffixIcon,
      this.prefixIcon,
      this.labelText,
      this.hintText,
      required this.textInputType,
      this.onChange,
      this.errorText,
      this.controller,
      this.textInputAction,
       this.obscureText=false,
        this.onPressed,
        this.readOnly = false,
        this.validator,
        this.maxLength,
        this.maxLines = 1,
        this.inputFormatter,
        this.focusNode,
        this.onFieldSubmitted,
        this.showHintRight = false,
        this.counterText,
         this.enable = true,
         this.autoFocus = false,
      });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        key: key,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller,
              onTap: onPressed,
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmitted,
              inputFormatters: inputFormatter,
              maxLines: maxLines,
              maxLength: maxLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              autofocus: autoFocus,
              // textAlignVertical: TextAlignVertical.center,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTapOutside: (v) => FocusScope.of(context).unfocus(),
              readOnly: readOnly,
              onChanged: (value) => field.didChange(value),
              textInputAction: textInputAction,
              style: Theme.of(context).textTheme.titleSmall,
              keyboardType: textInputType,
              obscureText: obscureText,
              enabled: enable,
              textAlign: showHintRight? TextAlign.right : TextAlign.start,
              decoration: InputDecoration(
                filled: true,
                // fillColor: Theme.of(context).dividerColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none
                ),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none
                ),
               contentPadding: const EdgeInsets.only(top: 0,bottom: 0,left: 12,right: 8),
               counterText: counterText,
                counter: null,
                labelStyle: Theme.of(context).textTheme.titleSmall,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                hintText: hintText,
                labelText: labelText
              ),
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  key: key,
                  '${field.errorText}',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12,color: Colors.red),
                ),
              ),
          ],
        );
      }
    );
  }
}
