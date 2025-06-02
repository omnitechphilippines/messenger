import 'package:flutter/widgets.dart';

class SizeConfig {
  static late Size size;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late BuildContext ctx;

  void init(BuildContext context) {
    ctx = context;
    size = MediaQuery.sizeOf(context);
    screenWidth = size.width;
    screenHeight = size.height;
  }
}
