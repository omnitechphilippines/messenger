import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../models/size_config.dart';

class StoryWidget extends StatelessWidget {
  final double size;
  final String imageUrl;
  final String text;
  final bool showGreenStrip;

  const StoryWidget({super.key, required this.size, required this.imageUrl, required this.text, this.showGreenStrip = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(shape: BoxShape.circle, image: showGreenStrip ? null : DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover), border: showGreenStrip ? Border.all(color: greenColor, width: 2) : null),
            child:
                showGreenStrip
                    ? Padding(padding: EdgeInsets.all(showGreenStrip ? 2.2 : 0), child: Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover))))
                    : null,
          ),
          const SizedBox(height: 10),
          SizedBox(width: size, child: Center(child: Text(text, overflow: TextOverflow.ellipsis, style: TextStyle(color: grayColor(SizeConfig.ctx).lightShade)))),
        ],
      ),
    );
  }
}
