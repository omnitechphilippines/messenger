import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../models/user.dart';
import '../../profile_page/profile_page.dart';
import 'profile_circular_widget.dart';

class HeaderSection extends StatefulWidget {
  final User user;

  const HeaderSection({super.key, required this.user});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) => ProfilePage(user: user, profilePageStatus: ProfilePageStatus.view)));
        },
        child: SizedBox(
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 16,
                      children: <Widget>[
                        IconButton(onPressed: () => Navigator.pop(context), padding: EdgeInsets.zero, splashRadius: 26, constraints: const BoxConstraints(maxHeight: 27, maxWidth: 27), icon: const Icon(LineIcons.arrowLeft, color: greenColor)),
                        ProfileCircularWidget(image: user.picture),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(user.name, style: TextStyle(color: blackColor(context).darkShade, fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 3),
                            Text("Online", style: TextStyle(color: blackColor(context).lightShade, fontSize: 13)),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) => CallAcceptDeclinePage(user: user)));
                              },
                              child: const Icon(LineIcons.phone, size: 27, color: greenColor),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(onTap: () {}, child: const Icon(LineIcons.video, size: 27, color: greenColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 8.0), child: Divider(thickness: 0.3, height: 0, color: grayColor(context).darkShade.withValues(alpha: 0.5))),
            ],
          ),
        ),
      ),
    );
  }
}
