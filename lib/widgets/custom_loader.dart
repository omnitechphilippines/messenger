import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/size_config.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) => Lottie.asset('assets/lotties/loader.json', width: SizeConfig.screenWidth * 0.3);
}
