import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/persons.dart';
import '../../models/user.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/gradient_icon_button.dart';
import '../home_page/widgets/status_bar.dart';

class CallListPage extends StatefulWidget {
  const CallListPage({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<CallListPage> createState() => _CallListPageState();
}

class _CallListPageState extends State<CallListPage> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  List<User> users = <User>[];

  @override
  void initState() {
    super.initState();
    users = persons.map((dynamic e) => User.fromJson(e)).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      floatingActionButton: FloatingActionButton(onPressed: () {}, backgroundColor: Colors.transparent, child: const GradientIconButton(size: 55, iconData: Icons.phone_forwarded)),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(left: 16.0), child: Text("Calls", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: blackColor(context).darkShade))),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Transform.rotate(
                        angle: isSearch ? pi * (90 / 360) : 0,
                        child: IconButton(
                          icon: Icon(isSearch ? Icons.add : Icons.search, size: 32),
                          splashRadius: 20,
                          onPressed: () {
                            setState(() {
                              isSearch = !isSearch;
                            });
                          },
                          color: greenColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                isSearch ? SearchBar(controller: controller) : StatusBar(addWidget: false, seeAllWidget: false, statusList: users),
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                controller: widget.scrollController,
                itemCount: users.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(thickness: 0.3);
                },
                itemBuilder:
                    (BuildContext context, int index) => CustomListTile(
                      imageUrl: users[index].picture,
                      title: "${users[index].firstName} ${users[index].lastName}",
                      subTitle: "May 7, 6:2$index PM",
                      onTap: () {},
                      numberOfCalls: 2,
                      customListTileType: CustomListTileType.call,
                      callStatus: CallStatus.accepted,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
