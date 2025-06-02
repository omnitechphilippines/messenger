import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';
import '../../models/size_config.dart';
import '../../widgets/gradient_icon_button.dart';
import '../../widgets/gradient_text.dart';
import '../root_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  double top = 0, left = 0;
  late Timer timer;
  late PageController pageController;
  int selectedPageIndex = 0;
  bool showForm = false;
  bool onOTPPage = false;

  OnBoardingPageModel get page => pages[selectedPageIndex];

  List<OnBoardingPageModel> pages = <OnBoardingPageModel>[
    OnBoardingPageModel("assets/images/network.png", "Connect With Anyone\nIn Any Form", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae."),
    OnBoardingPageModel("assets/images/handcuffs.png", "Complete Safety With\nFull Privacy", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae."),
    OnBoardingPageModel("assets/images/high-five.png", "Share With Your\nLoved Ones", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae."),
  ];

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startFloatingAnimation();
    pageController = PageController(initialPage: selectedPageIndex);
    super.initState();
  }

  startFloatingAnimation() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      const int threshold = 20;
      top = Random().nextInt(threshold).toDouble(); // 0-20
      left = Random().nextInt(threshold).toDouble(); // 0-20
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Stack(
        children: <Widget>[
          if (showForm)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: onOTPPage ? SizeConfig.screenHeight * 0.15 : SizeConfig.screenHeight * 0.05),
                    onOTPPage
                        ? Lottie.asset("assets/lotties/lock.json", height: 150.0, width: 150, repeat: false)
                        : ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => LinearGradient(colors: <Color>[greenGradient.darkShade, greenGradient.lightShade]).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                          child: ClipRRect(borderRadius: BorderRadius.circular(8.0), child: Lottie.asset("assets/lotties/wave.json", height: 300.0, repeat: false)),
                        ),
                  ],
                ),
              ],
            ),
          if (showForm)
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.screenHeight * 0.35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GradientText(onOTPPage ? "Enter the OTP" : "Welcome!", style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold), gradient: LinearGradient(colors: <Color>[greenGradient.lightShade, greenGradient.darkShade])),
                    ],
                  ),
                ],
              ),
            ),
          Column(
            children: <Widget>[
              if (!showForm)
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (int value) {},
                    itemCount: pages.length,
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final OnBoardingPageModel page = pages[index];
                      return Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.screenHeight * 0.3),
                          AnimatedPadding(
                            padding: EdgeInsets.only(top: top, left: left),
                            duration: const Duration(seconds: 1),
                            child: ShaderMask(
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(colors: <Color>[greenGradient.lightShade, greenGradient.darkShade]).createShader(bounds);
                              },
                              child: Image.asset(page.image, width: 100),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 800),
              width: SizeConfig.screenWidth * 0.9,
              height: showForm ? SizeConfig.screenHeight * 0.42 : SizeConfig.screenHeight * 0.33,
              child: Card(
                elevation: 3,
                shadowColor: blackColor(context).lightShade.withValues(alpha: 0.3),
                color: backgroundColor(context),
                child:
                    !showForm
                        ? Column(
                          children: <Widget>[
                            const SizedBox(height: 26),
                            Text(page.heading, textAlign: TextAlign.center, style: TextStyle(color: blackColor(context).darkShade, fontSize: 22, fontWeight: FontWeight.w700)),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14), child: Text(page.text, textAlign: TextAlign.center, style: TextStyle(color: blackColor(context).lightShade))),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      if (selectedPageIndex != 0) {
                                        if (pages.length - 1 == selectedPageIndex) {
                                          selectedPageIndex = 0;
                                          showForm = false;
                                          setState(() {});
                                        } else {
                                          setState(() {});
                                          pageController.animateToPage(selectedPageIndex - 1, curve: Curves.fastLinearToSlowEaseIn, duration: const Duration(seconds: 2));
                                          selectedPageIndex--;
                                        }
                                      }
                                    },
                                    child: GradientIconButton(size: 40, iconData: LineIcons.arrowLeft, isEnabled: selectedPageIndex != 0),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (selectedPageIndex != pages.length) {
                                        if (pages.length - 1 == selectedPageIndex) {
                                          showForm = true;
                                          setState(() {});
                                        } else {
                                          setState(() {});
                                          pageController.animateToPage(selectedPageIndex + 1, curve: Curves.fastLinearToSlowEaseIn, duration: const Duration(seconds: 2));
                                          selectedPageIndex++;
                                        }
                                      }
                                    },
                                    child: const GradientIconButton(size: 40, iconData: LineIcons.arrowRight),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                        : !onOTPPage
                        ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          if (onOTPPage) {
                                            onOTPPage = false;
                                          } else if (showForm) {
                                            showForm = false;
                                            selectedPageIndex = 0;
                                          }
                                          setState(() {});
                                        },
                                        icon: Icon(LineIcons.arrowLeft, color: blackColor(context).darkShade),
                                      ),
                                      const SizedBox(height: 12),
                                      Text("Login Account", textAlign: TextAlign.center, style: TextStyle(color: blackColor(context).darkShade, fontSize: 18, fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 3),
                                      Text("Hello, let's setup everything.", textAlign: TextAlign.center, style: TextStyle(color: blackColor(context).lightShade, fontSize: 12, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(child: Row(children: <Widget>[const CircleAvatar(radius: 16.0, backgroundImage: AssetImage('assets/images/ph-flag.webp')), Icon(Icons.arrow_drop_down, color: blackColor(context).darkShade)])),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0), border: Border.all(color: blackColor(context).lightShade, width: 1.5)),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[const CircleAvatar(radius: 14.0, backgroundImage: AssetImage('assets/images/ph-flag.webp')), Icon(Icons.arrow_drop_down, color: blackColor(context).lightShade)],
                                        ),
                                      ),
                                    ),
                                    Padding(padding: const EdgeInsets.only(left: 4, right: 8), child: Container(width: 1.5, height: 46, color: blackColor(context).lightShade)),
                                    Flexible(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          hintStyle: TextStyle(color: blackColor(context).lightShade),
                                          hintText: "phone number",
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(4)), gradient: LinearGradient(colors: <Color>[greenGradient.darkShade, greenGradient.lightShade])),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      onOTPPage = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                                  child: Container(height: 45.0, padding: EdgeInsets.zero, alignment: Alignment.center, child: const Text("REQUEST OTP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                                ),
                              ),
                            ],
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          if (onOTPPage) {
                                            onOTPPage = false;
                                          } else if (showForm) {
                                            showForm = false;
                                            selectedPageIndex = 0;
                                          }
                                          setState(() {});
                                        },
                                        icon: Icon(LineIcons.arrowLeft, color: blackColor(context).darkShade),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text("Verification Code", textAlign: TextAlign.center, style: TextStyle(color: blackColor(context).darkShade, fontSize: 18, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  Text("We have sent the code verification to\nYour Mobile Number", textAlign: TextAlign.center, style: TextStyle(color: blackColor(context).lightShade, fontSize: 12, fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("+639174701262", textAlign: TextAlign.center, style: TextStyle(color: blackColor(context).lightShade, fontSize: 16, fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 5),
                                        const GradientIconButton(size: 30, iconData: Icons.edit_outlined, iconSize: 15),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 40),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        spacing: 20,
                                        children: List<Widget>.generate(
                                          4,
                                          (int index) => Container(width: 45, height: 45, decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: !context.isDarkMode() ? const Color(0xFFF8F7FB) : Colors.white12)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(4)), gradient: LinearGradient(colors: <Color>[greenGradient.darkShade, greenGradient.lightShade])),
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) => const RootPage())),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                                  child: Container(height: 45.0, padding: EdgeInsets.zero, alignment: Alignment.center, child: const Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                                ),
                              ),
                            ],
                          ),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingPageModel {
  final String image;
  final String heading;
  final String text;

  OnBoardingPageModel(this.image, this.heading, this.text);
}
