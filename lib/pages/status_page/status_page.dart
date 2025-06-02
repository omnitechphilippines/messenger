import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final StoryController controller = StoryController();
  late List<StoryItem> storyItems;

  @override
  void initState() {
    storyItems = <StoryItem>[
      StoryItem.pageProviderImage(const AssetImage('assets/images/persons/my-day.png'), imageFit: BoxFit.contain),
      StoryItem.pageProviderImage(const AssetImage('assets/images/persons/my-day.png'), imageFit: BoxFit.contain),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: storyItems,
      controller: controller,
      // pass controller here too
      repeat: false,
      // should the stories be slid forever
      onStoryShow: (StoryItem s, int i) {},
      onComplete: () => Navigator.pop(context),
      onVerticalSwipeComplete: (Direction? direction) {
        if (direction == Direction.down) {
          Navigator.pop(context);
        }
      }, // To disable vertical swipe gestures, ignore this parameter.
      // Preferably for inline story view.
    );
  }
}
