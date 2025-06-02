import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../models/document.dart';
import '../../models/size_config.dart';
import '../../models/user.dart';
import '../../widgets/gradient_icon_button.dart';
import '../contact_page/contact_page.dart';
import 'circular_text_field.dart';
import 'widgets/circular_icon_button.dart';
import 'widgets/circular_message.dart';
import 'widgets/header_section.dart';
import 'widgets/map_screen.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.user});

  final User user;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool isSearch = false;
  bool isGifClicked = false;
  bool isRecordingStarted = false;
  bool isRecordingInDraft = false;
  bool isMenuPopupOpened = false;
  TextEditingController messageController = TextEditingController();
  TextEditingController gifController = TextEditingController();
  final ItemScrollController scrollController = ItemScrollController();
  List<MainMenu> mainMenus = <MainMenu>[
    MainMenu("Document", LineIcons.file, "document"),
    MainMenu("Camera", LineIcons.camera, "camera"),
    MainMenu("Gallery", LineIcons.image, "gallery"),
    MainMenu("Audio", LineIcons.audioFile, "audio"),
    MainMenu("Payment", Icons.currency_bitcoin, "payment"),
    MainMenu("Location", Icons.location_on_outlined, "location"),
    MainMenu("Contact", Icons.contact_page_outlined, "contact"),
  ];
  late List<Widget> messages;

  getMessages() {
    messages = <Widget>[
      const CircularMessage(fromFriend: true, messageType: MessageType.text, message: "Whatcha doing bro? 🤔"),
      const CircularMessage(fromFriend: false, messageType: MessageType.text, message: "nah! bro, nothing much but I found a great channel on YouTube"),
      const CircularMessage(fromFriend: true, messageType: MessageType.imageMedia, gifUrl: "https://i.giphy.com/media/oOTTyHRHj0HYY/giphy.webp"),
      const CircularMessage(fromFriend: false, messageType: MessageType.url, url: "https://www.youtube.com/watch?v=yqsb3gKP_N4"),
      const CircularMessage(fromFriend: false, messageType: MessageType.text, message: "Yeah! You can watch this video where he is explaining about a whatsapp clone!"),
      const CircularMessage(fromFriend: true, messageType: MessageType.text, message: "Wowww! That does sound cool"),
      const CircularMessage(fromFriend: true, messageType: MessageType.text, message: "I am going to subscribe the channel right NOW!!!"),
      CircularMessage(fromFriend: false, messageType: MessageType.doc, file: Document("arts.zip", 3258421, "zip")),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom(jump: true);
    });
  }

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  void dispose() {
    messageController.dispose();
    gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: Column(
        children: <Widget>[
          HeaderSection(user: widget.user),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ScrollablePositionedList.builder(itemScrollController: scrollController, itemCount: messages.length, itemBuilder: (BuildContext context, int index) => messages[index]),
            ),
          ),
          if (isRecordingStarted) SizedBox(width: SizeConfig.screenWidth, height: 80),
          isGifClicked
              ? SizedBox(
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: <Widget>[
                      CircularIconButton(iconData: Icons.gif, onTap: () => setState(() => isGifClicked = !isGifClicked)),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: CircularTextField(
                          controller: gifController,
                          onChanged: (String value) {
                            if (value.length < 2) {
                              setState(() {});
                            }
                          },
                          hintText: "Search...",
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      CircularIconButton(iconData: LineIcons.search, onTap: () => setState(() => FocusManager.instance.primaryFocus?.unfocus())),
                    ],
                  ),
                ),
              )
              : SizedBox(
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: <Widget>[
                      CircularIconButton(
                        iconData: Icons.gif,
                        onTap: () {
                          setState(() {
                            isGifClicked = !isGifClicked;
                            if (isGifClicked) {
                              FocusScope.of(context).unfocus();
                            }
                          });
                        },
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: CircularTextField(
                          controller: messageController,
                          onFieldSubmitted: (String value) {
                            final Widget message = convertStringToMessage(value);
                            messages.add(message);
                            setState(() {});
                            scrollToBottom();
                          },
                          onChanged: (String value) {
                            if (value.length < 2) {
                              setState(() {});
                            }
                          },
                          hintText: "Respond...",
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      messageController.text.isEmpty
                          ? Row(
                            children: <Widget>[
                              CircularIconButton(
                                iconData: LineIcons.microphone,
                                onLongPressStart: (LongPressStartDetails details) {
                                  messages.add(const CircularMessage(fromFriend: false, messageType: MessageType.audio));
                                  setState(() {});
                                  scrollToBottom();
                                },
                                onLongPressEnd: (LongPressEndDetails details) {
                                  if (details.localPosition.dx > 50) {
                                    messages.removeLast();
                                  } else {
                                    isRecordingInDraft = true;
                                  }
                                  setState(() {});
                                  scrollToBottom();
                                },
                              ),
                              const SizedBox(width: 8.0),
                              CircularIconButton(iconData: isRecordingStarted ? Icons.delete_outline : LineIcons.horizontalEllipsis, onTap: () => showMainMenuBottomSheet()),
                            ],
                          )
                          : Transform.rotate(
                            angle: 0.01745 * -30,
                            child: CircularIconButton(
                              iconData: Icons.send_outlined,
                              onTap: () async {
                                final Widget message = convertStringToMessage(messageController.text);
                                messages.add(message);
                                messageController.clear();
                                setState(() {});
                                scrollToBottom();
                              },
                            ),
                          ),
                    ],
                  ),
                ),
              ),
          if (isGifClicked)
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.2,
              child: Column(
                children: <Widget>[
                  FutureBuilder<List<String>>(
                    future: fetchGifs(gifController.text),
                    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No GIFs found.'));
                      }
                      final List<String> gifs = snapshot.data!;
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0, childAspectRatio: 1.4),
                          padding: EdgeInsets.zero,
                          itemCount: gifs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                final Widget message = convertImageToMessage(gifs[index]);
                                messages.add(message);
                                isGifClicked = false;
                                setState(() {});
                                scrollToBottom();
                              },
                              child: Image.network(gifs[index], width: 50, height: 30, fit: BoxFit.cover),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  scrollToBottom({bool jump = false}) {
    if (jump) {
      scrollController.jumpTo(index: messages.length);
    } else {
      scrollController.scrollTo(index: messages.length, duration: const Duration(milliseconds: 600));
    }
  }

  showMainMenuBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 80),
          child: Container(
            width: SizeConfig.screenWidth,
            height: 340,
            decoration: const BoxDecoration(color: Color(0xFF101010), borderRadius: BorderRadius.all(Radius.circular(22))),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
              itemCount: mainMenus.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    switch (mainMenus[index].key) {
                      case "document":
                        final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
                        final List<Widget> messages = convertFilesToMessages(result?.files);
                        messages.addAll(messages);
                        setState(() {});
                        scrollToBottom();
                        break;
                      case "camera":
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          final Widget message = CircularMessage(fromFriend: false, messageType: MessageType.imageMedia, gifBytes: await image.readAsBytes());
                          messages.add(message);
                          setState(() {});
                          scrollToBottom();
                        }
                        break;
                      case "gallery":
                        final ImagePicker picker = ImagePicker();
                        final List<XFile> images = await picker.pickMultiImage();
                        final List<Future<CircularMessage>> messages = images.map((XFile image) async => CircularMessage(fromFriend: false, messageType: MessageType.imageMedia, gifBytes: await image.readAsBytes())).toList();
                        for (final Future<CircularMessage> message in messages) {
                          messages.add((await message) as Future<CircularMessage>);
                        }
                        setState(() {});
                        scrollToBottom();
                        break;
                      case "audio":
                        final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: <String>["mp3", "wav", "flac"]);
                        final List<Widget> messages = convertFilesToMessages(result?.files);
                        messages.addAll(messages);
                        setState(() {});
                        scrollToBottom();
                        break;
                      case "payment":
                        break;
                      case "location":
                        final LatLng latLng = await Navigator.of(context).push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) => const MapScreen()));
                        final Widget message = convertLocationToMessage(latLng);
                        messages.add(message);
                        setState(() {});
                        scrollToBottom();
                        break;
                      case "contact":
                        final List<User>? selectedContacts = await Navigator.of(context).push(CupertinoPageRoute<List<User>>(builder: (BuildContext context) => const ContactPage()));
                        final List<Widget> messages = convertContactsToMessages(selectedContacts);
                        messages.addAll(messages);
                        setState(() {});
                        scrollToBottom();
                        break;
                    }
                  },
                  child: GradientIconButton(size: 60, iconData: mainMenus[index].iconData, text: mainMenus[index].text),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> convertXFilesToMessages(List<XFile>? files) async {
    if (files != null) {
      return files.map((XFile e) async => CircularMessage(fromFriend: false, messageType: MessageType.doc, file: Document(e.name, (await e.readAsBytes()).length, e.mimeType ?? ""))).toList();
    } else {
      return <Widget>[];
    }
  }

  List<Widget> convertFilesToMessages(List<PlatformFile>? files) {
    if (files != null) {
      return files.map((PlatformFile e) => CircularMessage(fromFriend: false, messageType: MessageType.doc, file: Document(e.name, e.size, e.extension ?? ""))).toList();
    } else {
      return <Widget>[];
    }
  }

  List<Widget> convertContactsToMessages(List<User>? messages) {
    if (messages != null) {
      return messages
          .map(
            (User e) => CircularMessage(
              fromFriend: false,
              messageType: MessageType.contact,
              contact: Contact(name: Name(first: e.firstName.toUpperCase() + e.firstName.substring(1), last: e.lastName.toUpperCase() + e.lastName.substring(1)), phones: <Phone>[Phone(e.phoneNumber)]),
            ),
          )
          .toList();
    } else {
      return <Widget>[];
    }
  }

  Widget convertImageToMessage(String? gifUrl) {
    return CircularMessage(fromFriend: false, messageType: MessageType.imageMedia, gifUrl: gifUrl);
  }

  Widget convertLocationToMessage(LatLng latLng) {
    return CircularMessage(fromFriend: false, messageType: MessageType.location, latLng: latLng);
  }

  Widget convertStringToMessage(String text) {
    return CircularMessage(fromFriend: false, messageType: MessageType.text, message: text);
  }

  Future<List<String>> fetchGifs(String query) async {
    const String apiKey = 'NMFj5k2Slp67Tg2lSUANshwMFS9qTiB1';
    final String url = query.isEmpty ? 'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=10&rating=G' : 'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=10&offset=0&rating=G&lang=en';

    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((dynamic gif) => gif['images']['original']['url'] as String).toList();
    } else {
      throw Exception('Failed to load GIFs');
    }
  }
}

class MainMenu {
  final String text;
  final IconData iconData;
  final String key;

  MainMenu(this.text, this.iconData, this.key);
}
