import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../models/size_config.dart';

class CircularTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  const CircularTextField({super.key, required this.controller, required this.hintText, required this.onChanged, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: !controller.text.contains("\n") ? null : 40,
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: blackColor(SizeConfig.ctx).lightShade.withValues(alpha: 0.5))),
      child: Center(
        child: TextFormField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white38),
          maxLines: 6,
          minLines: 1,
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 15, bottom: 8, top: 8, right: 15),
            hintText: hintText,
            hintStyle: TextStyle(color: blackColor(SizeConfig.ctx).darkShade.withValues(alpha: 0.6)),
          ),
        ),
      ),
    );
  }
}
