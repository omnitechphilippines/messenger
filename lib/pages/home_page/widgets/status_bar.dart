import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/colors.dart';
import '../../../models/user.dart';
import '../../../widgets/gradient_icon_button.dart';
import '../../status_page/status_page.dart';
import 'story_widget.dart';

class StatusBar extends StatelessWidget {
  final List<User> statusList;
  final GestureTapCallback? onNewStatusClicked;
  final bool addWidget;
  final bool seeAllWidget;

  const StatusBar({super.key, required this.statusList, this.onNewStatusClicked, this.addWidget = true, this.seeAllWidget = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey<int>(1),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              children: <Widget>[
                if(addWidget) GestureDetector(onTap: onNewStatusClicked, child: const GradientIconButton(size: 60, iconData: Icons.add, text: "New Status")),
                if(addWidget) const SizedBox(width: 8),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: statusList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) => const StatusPage()));
                        },
                        child: StoryWidget(size: 60, showGreenStrip: addWidget && (index == 2 || index == 3), text: "${statusList[index].firstName} ${statusList[index].lastName}", imageUrl: statusList[index].picture),
                      );
                    },
                  ),
                ),
                if(seeAllWidget) const SizedBox(width: 10),
                if(seeAllWidget) const Icon(LineIcons.arrowRight, color: greenColor),
                if(seeAllWidget) const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Divider(height: 0, thickness: 0.6),
      ],
    );
  }
}
