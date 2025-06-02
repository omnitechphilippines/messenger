import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../constants/colors.dart';
import '../models/size_config.dart';
import 'call_page/call_list_page.dart';
import 'home_page/home_page.dart';
import 'profile_page/main_profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int selectedIndex = 1;
  final ScrollController scrollController = ScrollController();
  StreamSubscription<ReceivedAction>? _actionStreamSubscription;

  void listen() async => await _actionStreamSubscription?.cancel();

  @override
  void initState() {
    super.initState();
    listen();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) => setState(() => selectedIndex = index),
        backgroundColor: backgroundColor(context),
        selectedItemColor: greenColor,
        unselectedItemColor: const Color(0xff6c788a),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(LineIcons.phone), label: 'Calls'),
          BottomNavigationBarItem(icon: Icon(LineIcons.sms), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(LineIcons.user), label: 'Profile'),
        ],
      ),
    );
  }

  Widget getBody() {
    switch (selectedIndex) {
      case 0:
        return CallListPage(scrollController: scrollController);
      case 1:
        return HomePage(scrollController: scrollController);
      case 2:
        return MainProfilePage(scrollController: scrollController);
      default:
        return HomePage(scrollController: scrollController);
    }
  }
}
