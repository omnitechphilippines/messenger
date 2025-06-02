import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../models/user.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/gradient_icon_button.dart';
import '../home_page/widgets/status_bar.dart';
import '../profile_page/widgets/setting_tile.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  List<User> selectedContacts = <User>[];
  List<Contact> initialContacts = <Contact>[];
  List<Contact> contacts = <Contact>[];

  bool isContactSelected(Contact contact) => selectedContacts.any((User userContact) => userContact.phoneNumber == contact.phones.first.number);

  @override
  void initState() {
    super.initState();
    getContacts();
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
          selectedContacts.isNotEmpty
              ? FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context, selectedContacts);
                },
                backgroundColor: Colors.transparent,
                child: const GradientIconButton(size: 55, iconData: Icons.send),
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
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(left: 16.0), child: Text(isSearch ? "Search" : "Contacts", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: blackColor(context).darkShade))),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        icon: Icon(isSearch ? Icons.close : Icons.search, size: 32),
                        splashRadius: 20,
                        onPressed: () {
                          isSearch = !isSearch;
                          if (!isSearch) {
                            contacts = initialContacts;
                          }
                          setState(() {});
                        },
                        color: greenColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        icon: const Icon(Icons.refresh, size: 32),
                        splashRadius: 20,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contacts Refreshed')));
                          getContacts();
                        },
                        color: greenColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                isSearch
                    ? SearchBar(
                      controller: controller,
                      onChanged: (String value) {
                        contacts = initialContacts.where((Contact element) => element.displayName.toLowerCase().contains(value)).toList();
                        setState(() {});
                      },
                    )
                    : selectedContacts.isNotEmpty
                    ? StatusBar(
                      statusList: selectedContacts,
                      addWidget: false,
                      seeAllWidget: false,
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
                    )
                    : Column(
                      children: <Widget>[
                        const SettingTile(title: "New Group", shouldGreenGlow: true, iconData: Icons.group),
                        SettingTile(
                          title: "New Contact",
                          shouldGreenGlow: true,
                          onTap: () {
                            FlutterContacts.openExternalInsert().then((Contact? contact) {});
                          },
                          iconData: Icons.person_add,
                        ),
                      ],
                    ),
              ],
            ),
            Expanded(
              child:
                  contacts.isNotEmpty
                      ? ListView.separated(
                        padding: const EdgeInsets.only(top: 10),
                        controller: widget.scrollController,
                        itemCount: contacts.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(thickness: 0.3);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final Contact contact = contacts[index];
                          return CustomListTile(
                            imageBytes: contact.photoOrThumbnail,
                            imageUrl: "assets/images/william-david.jpg",
                            isSelected: isContactSelected(contact),
                            title: contact.displayName,
                            subTitle: contact.phones.first.number,
                            messageCounter: null,
                            onTap: () {
                              if (selectedContacts.isNotEmpty) {
                                setState(() {
                                  if (selectedContacts.any((User userContact) => userContact.phoneNumber == contact.phones.first.number)) {
                                    selectedContacts.removeWhere((User userContact) => userContact.phoneNumber == contact.phones.first.number);
                                  } else {
                                    selectedContacts.add(convertContactToUser(contact));
                                  }
                                });
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                if (isContactSelected(contact)) {
                                  selectedContacts.removeWhere((User userContact) => userContact.phoneNumber == contact.phones.first.number);
                                } else {
                                  selectedContacts.add(convertContactToUser(contact));
                                }
                              });
                            },
                            customListTileType: CustomListTileType.contact,
                            timeFrame: "",
                          );
                        },
                      )
                      : const Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[CustomLoader()]),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Contact>?> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true, withThumbnail: true);
      setState(() {
        initialContacts = contacts;
        contacts = contacts;
      });
    }
    return null;
  }
}

User convertContactToUser(Contact contact) {
  return User.fromJson(<String, Object>{
    'email': 'william.david@example.com',
    'gender': 'male',
    'phone_number': contact.phones.first.number,
    'birthdate': 498456350,
    'location': <String, Object>{'street': '1507 rue abel-ferry', 'city': 'aclens', 'state': 'schaffhausen', 'postcode': 4583},
    'username': 'orangepanda797',
    'password': 'pinkfloyd',
    'first_name': contact.name.first,
    'last_name': contact.name.last,
    'title': 'monsieur',
    'picture': 'assets/images/william-david.jpg',
  });
}
