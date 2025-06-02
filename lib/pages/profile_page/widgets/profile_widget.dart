import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/colors.dart';
import '../../../models/size_config.dart';

class ProfileWidget extends StatelessWidget {
  final String name;
  final String image;
  final GestureTapCallback onLogoutClick;
  final GestureTapCallback onTap;

  const ProfileWidget({super.key, required this.name, required this.image, required this.onLogoutClick, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
}
