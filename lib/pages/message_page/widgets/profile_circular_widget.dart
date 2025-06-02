import 'package:flutter/material.dart';
import 'package:messenger/constants/colors.dart';

class ProfileCircularWidget extends StatefulWidget {
  final String image;

  const ProfileCircularWidget({super.key, required this.image});

  @override
  State<ProfileCircularWidget> createState() => _ProfileCircularWidgetState();
}

class _ProfileCircularWidgetState extends State<ProfileCircularWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(width: 50, height: 50, decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage(widget.image)))),
        Positioned(
          bottom: -5,
          right: -5,
          child: Container(
            decoration: BoxDecoration(color: !context.isDarkMode() ? Colors.white : Colors.black, border: Border.all(width: 3, color: !context.isDarkMode() ? Colors.white : Colors.black), shape: BoxShape.circle),
            child: const Padding(padding: EdgeInsets.all(2.0), child: Icon(Icons.circle, size: 14, color: greenColor)),
          ),
        ),
      ],
    );
  }
}
