import 'package:flutter/material.dart';
import 'package:simple_link_preview/simple_link_preview.dart';

import '../../../../constants/colors.dart';
import '../../../../models/size_config.dart';

class UrlMessage extends StatefulWidget {
  final String url;
  final bool fromFriend;

  const UrlMessage({super.key, required this.url, required this.fromFriend});

  @override
  State<UrlMessage> createState() => _UrlMessageState();
}

class _UrlMessageState extends State<UrlMessage> {
  late bool fromFriend;
  late String url;

  @override
  void initState() {
    fromFriend = widget.fromFriend;
    url = widget.url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: fromFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: SizeConfig.screenWidth * 0.5,
            height: SizeConfig.screenWidth * 0.6,
            decoration: BoxDecoration(
              border: Border.all(color: blackColor(SizeConfig.ctx).lightShade.withValues(alpha: 0.18)),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(fromFriend ? 0 : 40), topLeft: const Radius.circular(40), topRight: const Radius.circular(40), bottomRight: Radius.circular(fromFriend ? 40 : 0)),
            ),
            child: FutureBuilder<LinkPreview?>(
              future: SimpleLinkPreview.getPreview(url),
              builder: (BuildContext context, AsyncSnapshot<LinkPreview?> data) {
                if (data.hasData) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: SizeConfig.screenWidth * 0.5,
                        height: SizeConfig.screenWidth * 0.25,
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data.data!.image!), fit: BoxFit.cover), borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                      ),
                      Padding(padding: const EdgeInsets.all(4.0), child: Text(data.data!.title!, style: TextStyle(color: blackColor(context).darkShade, fontSize: 12, fontWeight: FontWeight.w600))),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0), child: Text(data.data!.description!, style: TextStyle(color: blackColor(context).lightShade, fontSize: 12), maxLines: 4, overflow: TextOverflow.ellipsis)),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
