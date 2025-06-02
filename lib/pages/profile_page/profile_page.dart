import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../models/user.dart';
import 'main_profile_page_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.user, required this.profilePageStatus});

  final User user;
  final ProfilePageStatus profilePageStatus;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool toggle = true;
  late User user;
  List<IconData> icons = <IconData>[LineIcons.phone, LineIcons.video, LineIcons.search, LineIcons.indianRupeeSign];
  List<dynamic> images = List<dynamic>.generate(17, (int index) => "assets/images/persons/my-day.png");
  int selectedGender = 0;

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  Widget getBody() {
    switch (widget.profilePageStatus) {
      case ProfilePageStatus.view:
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(onPressed: () => Navigator.pop(context), padding: EdgeInsets.zero, splashRadius: 26, constraints: const BoxConstraints(maxHeight: 27, maxWidth: 27), icon: Icon(LineIcons.arrowLeft, color: blackColor(context).lightShade)),
                      IconButton(onPressed: () {}, padding: EdgeInsets.zero, splashRadius: 26, constraints: const BoxConstraints(maxHeight: 27, maxWidth: 27), icon: Icon(LineIcons.verticalEllipsis, color: blackColor(context).lightShade)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(width: 140, height: 140, decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage(user.picture), fit: BoxFit.cover))),
                const SizedBox(height: 16),
                Text(user.name, style: TextStyle(color: blackColor(context).darkShade, fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text(user.phoneNumber, style: TextStyle(color: blackColor(context).lightShade, fontSize: 14, fontWeight: FontWeight.w400)), const SizedBox(width: 4), const Icon(LineIcons.userCheck, color: greenColor, size: 16)],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    icons.length,
                    (int index) => Padding(
                      padding: EdgeInsets.only(right: index != icons.length - 1 ? 14.0 : 0),
                      child: Container(
                        decoration: const BoxDecoration(color: Color(0xFF262831), borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: Padding(padding: const EdgeInsets.all(12.0), child: Icon(icons[index], size: 16, color: blackColor(context).lightShade)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Divider(thickness: 0.3, indent: 100, endIndent: 100, color: grayColor(context).darkShade.withValues(alpha: 0.6)),
                const SizedBox(height: 16),
                settingTile(
                  title: "Mute Notifications",
                  settingTrailing: SettingTrailing.toggle,
                  onToggle: (bool value) {
                    setState(() {
                      toggle = value;
                    });
                  },
                  toggle: toggle,
                  iconData: LineIcons.bell,
                ),
                const SizedBox(height: 32),
                Padding(padding: const EdgeInsets.only(left: 22.0, bottom: 10), child: Row(children: <Widget>[Text("MEDIA", style: TextStyle(fontWeight: FontWeight.w700, color: grayColor(context).lightShade))])),
                SizedBox(
                  height: 250,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 22),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(decoration: BoxDecoration(color: const Color(0xFF262831), borderRadius: BorderRadius.circular(22)));
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Column(children: <Widget>[settingTile(title: "Block ${user.name}", shouldRedGlow: true, iconData: LineIcons.ban), settingTile(title: "Report ${user.name}", shouldRedGlow: true, iconData: LineIcons.thumbsDown)]),
              ],
            ),
          ),
        );
      case ProfilePageStatus.personal:
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        splashRadius: 26,
                        constraints: const BoxConstraints(maxHeight: 27, maxWidth: 27),
                        icon: Icon(LineIcons.arrowLeft, color: blackColor(context).lightShade),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(width: 140, height: 140, decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage(user.picture), fit: BoxFit.cover))),
                const SizedBox(height: 16),
                Text(user.name, style: TextStyle(color: blackColor(context).darkShade, fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text(user.phoneNumber, style: TextStyle(color: blackColor(context).lightShade, fontSize: 14, fontWeight: FontWeight.w400)), const SizedBox(width: 4), const Icon(LineIcons.userCheck, color: greenColor, size: 16)],
                ),
                const SizedBox(height: 32),
                customListTile("full name"),
                const SizedBox(height: 16),
                customListTile("about"),
                const SizedBox(height: 16),
                customListTile("email"),
                const SizedBox(height: 16),
                customMultiChoice("gender", <String>["male", "female", "other"], selectedGender, (int index) {
                  setState(() {
                    selectedGender = index;
                  });
                }),
                const SizedBox(height: 16),
                Column(children: <Widget>[settingTile(title: "Logout", shouldRedGlow: true, iconData: LineIcons.alternateSignOut), settingTile(title: "Delete Account", shouldRedGlow: true, iconData: LineIcons.ban)]),
              ],
            ),
          ),
        );
    }
  }

  Widget customMultiChoice(String heading, List<String> choices, int selected, ValueChanged<int> onSelect) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(left: 22.0, bottom: 10), child: Row(children: <Widget>[Text(heading.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, color: grayColor(context).lightShade))])),
        SizedBox(
          width: MediaQuery.of(context).size.width - 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(
              choices.length,
              (int index) => InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  onSelect(index);
                },
                child: Container(
                  width: ((MediaQuery.of(context).size.width - 44) / choices.length) - 10,
                  height: 50,
                  decoration: BoxDecoration(color: selected == index ? greenColor : const Color(0xFF262831), borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Text(choices[index].toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, color: selected == index ? backgroundColor(context) : blackColor(context).lightShade))),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customListTile(String heading) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(left: 22.0, bottom: 10), child: Row(children: <Widget>[Text(heading.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, color: grayColor(context).lightShade))])),
        Container(width: MediaQuery.of(context).size.width - 44, height: 50, decoration: BoxDecoration(color: const Color(0xFF262831), borderRadius: BorderRadius.circular(8))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: backgroundColor(context), body: getBody());
  }
}
