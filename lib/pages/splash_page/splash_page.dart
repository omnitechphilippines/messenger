import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/colors.dart';
import '../../models/size_config.dart';
import '../../widgets/gradient_text.dart';
import '../onboarding_page/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<Null>.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute<dynamic>(builder: (BuildContext builder) => const OnBoardingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.isDarkMode()? Colors.black : const Color(0xFFFEF7FF),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(borderRadius: BorderRadius.circular(8.0), child: Image.asset("assets/images/logo.png", height: 100.0, width: 100.0, fit: BoxFit.cover)),
                const SizedBox(height: 20),
                GradientText("Messenger", style: const TextStyle(fontSize: 28), gradient: LinearGradient(colors: <Color>[greenGradient.lightShade, greenGradient.darkShade])),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('from', style: TextStyle(color: grayColor(context).lightShade.withValues(alpha: 0.4), fontSize: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[const Icon(LineIcons.infinity, size: 32, color: greenColor), const SizedBox(width: 5), Text("Meta", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: grayColor(context).lightShade))],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.12),
            ],
          ),
        ],
      ),
    );
  }
}
