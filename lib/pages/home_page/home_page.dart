import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/persons.dart';
import '../../main.dart';
import '../../models/user.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/gradient_icon_button.dart';
import '../contact_page/contact_page.dart';
import '../message_page/message_page.dart';
import 'widgets/status_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  List<User> chats = <User>[];
  List<User> statusList = <User>[];

  @override
  void initState() {
    super.initState();
    chats = persons.map((dynamic e) => User.fromJson(e)).toList();
    chats.insert(0, rick);
    statusList = persons.map((dynamic e) => User.fromJson(e)).toList().reversed.toList();
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
      floatingActionButton:
          !isSearch
              ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) => const ContactPage()));
                },
                backgroundColor: Colors.transparent,
                child: const GradientIconButton(size: 55, iconData: Icons.group_add),
              )
              : const SizedBox(),
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
                    Padding(padding: const EdgeInsets.only(left: 16.0), child: Text(isSearch ? "Search" : "Chats", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: blackColor(context).darkShade))),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        icon: Icon(isSearch ? Icons.close : Icons.search, size: 32),
                        splashRadius: 20,
                        onPressed: () {
                          setState(() {
                            if (isSearch) {
                              isSearch = false;
                            }
                            controller.clear();
                          });
                        },
                        color: greenColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                isSearch
                    ? SearchBar(controller: controller)
                    : StatusBar(
                      statusList: statusList,
                      onNewStatusClicked: () async {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 70),
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              decoration: BoxDecoration(color: context.isDarkMode() ? Colors.black26 : Colors.white, borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Are you sure to logout ?", style: TextStyle(fontWeight: FontWeight.w600, color: blackColor(context).darkShade, fontSize: 19)),
                                  const SizedBox(height: 16),
                                  OverflowBar(
                                    alignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ElevatedButton(
                                        style: ButtonStyle(fixedSize: WidgetStateProperty.all(const Size(150, 30)), backgroundColor: WidgetStateProperty.all(greenColor)),
                                        onPressed: () {},
                                        child: const Text('Yes, log out!', style: TextStyle(fontWeight: FontWeight.w500)),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          fixedSize: WidgetStateProperty.all(const Size(100, 30)),
                                          backgroundColor: WidgetStateProperty.all(backgroundColor(context)),
                                          side: WidgetStateProperty.all(const BorderSide(color: greenColor)),
                                        ),
                                        onPressed: () {},
                                        child: const Text('Cancel', style: TextStyle(color: greenColor)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
              ],
            ),
            Expanded(
              child:
                  isSearch && controller.text.trim().isNotEmpty
                      ? const Center(child: CustomLoader())
                      : ListView.separated(
                        padding: const EdgeInsets.only(top: 10),
                        controller: widget.scrollController,
                        itemCount: 10,
                        separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0.3),
                        itemBuilder:
                            (BuildContext context, int index) => Slidable(
                              key: UniqueKey(),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.25,
                                dismissible: DismissiblePane(onDismissed: () => setState(() => chats.removeAt(index))),
                                children: <Widget>[CustomSlidableAction(backgroundColor: greenColor, onPressed: (BuildContext context) {}, child: const Center(child: Icon(LineIcons.userSecret, color: Colors.white, size: 30)))],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: (0.25) * 2,
                                dismissible: DismissiblePane(onDismissed: () {}),
                                children: <Widget>[
                                  CustomSlidableAction(onPressed: (_) {}, backgroundColor: grayColor(context).lightShade, foregroundColor: Colors.white, child: const Icon(Icons.more_horiz_outlined, size: 30)),
                                  CustomSlidableAction(onPressed: (_) {}, backgroundColor: const Color(0xFFE25C5C), foregroundColor: Colors.white, child: const Icon(Icons.delete_outline, size: 30)),
                                ],
                              ),
                              child: CustomListTile(
                                isOnline: index == 3 ? false : true,
                                imageUrl: chats[index].picture,
                                title: "${chats[index].firstName} ${chats[index].lastName}",
                                subTitle: sentences[index],
                                messageCounter: index == 0 ? 3 : null,
                                onTap: () => Navigator.of(context).push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) => MessagePage(user: chats[index]))),
                                participantImages: index == 3 ? chats.map((User chat) => chat.picture).toList() : null,
                                customListTileType: index == 3 ? CustomListTileType.group : CustomListTileType.message,
                                timeFrame: "16:32",
                              ),
                            ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
