import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.capitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.dense = true,
    this.onTap,
    this.onSave,
    this.onChanged,
    this.autoFocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.hasBorder = true,
  });

  final bool dense;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool autoFocus;
  final bool readOnly;
  final TextEditingController? controller;
  final TextCapitalization capitalization;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final String? Function(String?)?  onSave;
  final Function(String)? onChanged;
  final int maxLines;
  final int? maxLength;
  final bool hasBorder;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
        border: Border.all(
          color: !widget.hasBorder || widget.readOnly
              ? Colors.yellow
              : Colors.black, // Specify the border color here
          width: 1.0, // Adjust the border width as needed
        ),
      ),
      width: 350,
      child: TextFormField(
        onSaved: widget.onSave,
        onTap: widget.onTap,
        validator: widget.validator,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        obscuringCharacter: '*',
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        maxLines: widget.maxLines,
        readOnly: widget.readOnly,
        cursorRadius: const Radius.circular(0),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        autofocus: widget.autoFocus,
        obscureText: widget.isPassword && !visible ? true : false,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          isDense: widget.dense,
          hintText: widget.hintText,
          fillColor: Colors.grey,
          filled: true,
          prefixIcon: widget.maxLines > 1 && widget.prefixIcon != null
              ? Column(
                  children: [if (widget.prefixIcon != null) widget.prefixIcon!],
                )
              : widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() => visible = !visible);
                  },
                  icon: Icon(
                    visible
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: Colors.black,
                  ))
              : widget.suffixIcon,
          hintStyle:
              TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: !widget.hasBorder || widget.readOnly
                  ? Colors.grey
                  : Colors.yellow,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: !widget.hasBorder || widget.readOnly
                  ? Colors.grey
                  : Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: !widget.hasBorder || widget.readOnly
                  ? Colors.grey
                  : Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
