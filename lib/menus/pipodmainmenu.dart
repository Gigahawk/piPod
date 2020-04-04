import 'package:flutter/material.dart';
import 'package:piPod/pipodlistview.dart';

class PiPodMainMenu extends StatelessWidget {
  PiPodMainMenu ({Key key}): super(key: key);

  static List<String> entryList = [
    "Music",
    "Extras",
    "Settings",
    "Shuffle Songs"
  ];

  @override
  Widget build(BuildContext context) {
    return PiPodListView(entryList);
  }
}