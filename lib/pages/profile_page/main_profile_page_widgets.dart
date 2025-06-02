import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../models/size_config.dart';

Widget profileWidget({required String name, required String image, required GestureTapCallback onLogoutClick, required GestureTapCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 70,
        child: Row(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(width: 70, height: 70, decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover))),
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, border: Border.all(width: 3, color: backgroundColor(SizeConfig.ctx)), shape: BoxShape.circle),
                    child: const Padding(padding: EdgeInsets.all(4.0), child: Icon(LineIcons.pen, size: 14, color: greenColor)),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: TextStyle(color: blackColor(SizeConfig.ctx).darkShade, fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text("View profile", style: TextStyle(color: blackColor(SizeConfig.ctx).lightShade)),
              ],
            ),
            const Spacer(),
            Padding(padding: const EdgeInsets.only(right: 2.0), child: GestureDetector(onTap: onLogoutClick, child: const Icon(LineIcons.alternateSignOut, size: 30, color: Colors.redAccent))),
          ],
        ),
      ),
    ),
  );
}

Widget settingTile({required IconData iconData, SettingTrailing? settingTrailing, GestureTapCallback? onTap, bool shouldRedGlow = false, bool shouldGreenGlow = false, required String title, bool? toggle, ValueSetter<bool>? onToggle}) {
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
            if (settingTrailing == SettingTrailing.toggle)
              Transform.scale(scale: 0.8, child: Switch.adaptive(inactiveThumbColor: Colors.white, inactiveTrackColor: const Color(0xFF9E9E9E), onChanged: onToggle!, activeColor: Colors.redAccent, value: toggle!)),
            if (settingTrailing == SettingTrailing.arrow) Icon(LineIcons.angleRight, color: blackColor(SizeConfig.ctx).lightShade),
          ],
        ),
      ),
    ),
  );
}
