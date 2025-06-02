import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/colors.dart';
import '../../../models/size_config.dart';

enum SettingTrailing { toggle, arrow }

class SettingTile extends StatelessWidget {
  final IconData iconData;
  final SettingTrailing? settingTrailing;
  final GestureTapCallback? onTap;
  final bool shouldRedGlow;
  final bool shouldGreenGlow;
  final String title;
  final bool? toggle;
  final ValueSetter<bool>? onToggle;

  const SettingTile({super.key, required this.iconData, this.settingTrailing, this.onTap, this.shouldRedGlow = false, this.shouldGreenGlow = false, required this.title, this.toggle, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height: 55,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                child: Row(
                  children: <Widget>[
                    Icon(
                      iconData,
                      color:
                          shouldRedGlow
                              ? Colors.redAccent
                              : shouldGreenGlow
                              ? greenColor
                              : blackColor(SizeConfig.ctx).lightShade,
                      size: 26,
                    ),
                    const SizedBox(width: 20),
                    Text(title, style: TextStyle(color: shouldRedGlow ? Colors.redAccent : blackColor(SizeConfig.ctx).darkShade, fontSize: 17)),
                  ],
                ),
              ),
              const Spacer(),
              if (settingTrailing == SettingTrailing.toggle) Transform.scale(scale: 0.8, child: Switch.adaptive(inactiveThumbColor: Colors.white, inactiveTrackColor: const Color(0xFF9E9E9E), onChanged: onToggle!, activeColor: Colors.redAccent, value: toggle!)),
              if (settingTrailing == SettingTrailing.arrow) Icon(LineIcons.angleRight, color: blackColor(SizeConfig.ctx).lightShade),
            ],
          ),
        ),
      ),
    );
  }
}
