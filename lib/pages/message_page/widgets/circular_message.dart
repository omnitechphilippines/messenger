import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:latlong2/latlong.dart';

import '../../../constants/enums.dart';
import '../../../models/document.dart';
import 'messages/contact_message.dart';
import 'messages/document_message.dart';
import 'messages/gif_message.dart';
import 'messages/location_message.dart';
import 'messages/text_message.dart';
import 'messages/url_message.dart';

class CircularMessage extends StatelessWidget {
  final String? message;
  final String? gifUrl;
  final Uint8List? gifBytes;
  final String? audio;
  final String? url;
  final Document? file;
  final Contact? contact;
  final LatLng? latLng;
  final bool fromFriend;
  final MessageType messageType;

  const CircularMessage({super.key, this.message, this.gifUrl, this.gifBytes, this.audio, this.url, this.file, this.contact, this.latLng, required this.fromFriend, required this.messageType});

  @override
  Widget build(BuildContext context) {
    switch (messageType) {
      case MessageType.text:
        return TextMessage(message: message!, fromFriend: fromFriend);
      case MessageType.audio:
        return const SizedBox();
      case MessageType.video:
        return const SizedBox();
      case MessageType.imageMedia:
        return GifMessage(gifUrl: gifUrl, fromFriend: fromFriend, gifBytes: gifBytes);
      case MessageType.url:
        return UrlMessage(url: url!, fromFriend: fromFriend);
      case MessageType.doc:
        return DocumentMessage(file: file!, fromFriend: fromFriend);
      case MessageType.contact:
        return ContactMessage(contact: contact!, fromFriend: fromFriend);
      case MessageType.location:
        return LocationMessage(latLng: latLng!, fromFriend: fromFriend);
    }
  }
}
