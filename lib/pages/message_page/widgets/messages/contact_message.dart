import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

import '../../../../constants/colors.dart';
import '../../../../models/size_config.dart';
import '../../../../widgets/gradient_icon_button.dart';
import '../../../contact_page/contact_page.dart';
import '../../message_page.dart';

class ContactMessage extends StatefulWidget {
  final Contact contact;
  final bool fromFriend;

  const ContactMessage({super.key, required this.contact, required this.fromFriend});

  @override
  State<ContactMessage> createState() => _ContactMessageState();
}

class _ContactMessageState extends State<ContactMessage> {
  late bool fromFriend;
  late Contact contact;

  @override
  void initState() {
    super.initState();
    fromFriend = widget.fromFriend;
    contact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: fromFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: SizeConfig.screenWidth * 0.8,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(fromFriend ? 0 : 40), topLeft: const Radius.circular(40), topRight: const Radius.circular(40), bottomRight: Radius.circular(fromFriend ? 40 : 0)),
              color: fromFriend ? const Color(0xFF313131) : null,
              gradient: fromFriend ? null : LinearGradient(colors: <Color>[greenGradient.lightShade, greenGradient.darkShade]),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Container(
                        width: (SizeConfig.screenWidth * 0.8) - 20,
                        decoration: BoxDecoration(color: Colors.grey.shade200.withValues(alpha: 0.5), borderRadius: const BorderRadius.all(Radius.circular(40))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(width: 10),
                            SizedBox(width: 36, height: 36, child: ClipOval(child: SizedBox.fromSize(size: const Size.fromRadius(50), child: Image.asset('assets/images/william-david.jpg')))),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("${contact.name.first} ${contact.name.last}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fromFriend ? Colors.white : Colors.black)),
                                Text(contact.phones.first.number, style: TextStyle(fontSize: 8, color: fromFriend ? Colors.white : Colors.black)),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GradientIconButton(
                                  size: 30,
                                  iconData: Icons.message,
                                  iconSize: 16,
                                  onTap: () => Navigator.of(context).push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) => MessagePage(user: convertContactToUser(contact)))),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[Text("7:31 PM", style: TextStyle(fontSize: 12, color: fromFriend ? Colors.white70 : Colors.black87)), SizedBox(width: fromFriend ? 30 : 10)]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
