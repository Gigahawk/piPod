import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PiPodListView extends StatelessWidget {
  const PiPodListView(this.entryList, {Key key}) : super(key: key);
  final List<String> entryList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemExtent: 20.0,
      itemBuilder: (context, index) => FocusableText(
          entryList[index],
          autofocus: index == 0,
      ),
      itemCount: entryList.length,
    );
  }
}

class FocusableText extends StatelessWidget {
  const FocusableText(this.data, {Key key, this.autofocus}) : super(key: key);

  final String data;
  final bool autofocus;

  bool _onKeyPressed(FocusNode node, RawKeyEvent event, BuildContext context) {
    if (event is RawKeyDownEvent) {
      if(event.logicalKey == LogicalKeyboardKey.enter) {
        _pushMenu(context);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        print("Escaping");
        Navigator.of(context).maybePop();
        return true;
      }
      return false;
    }
    return false;
  }

  void _pushMenu(BuildContext context) {
    print("$data selected");
    Navigator.of(context)
      .pushNamed(data.toLowerCase().replaceAll(" ", "_"));
  }

  bool _onFocusChanged(bool gotFocus) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) => _onKeyPressed(node, event, context),
      onFocusChange: _onFocusChanged,
      autofocus: autofocus,
      child: Builder(builder: (BuildContext context) {
        final FocusNode focusNode = Focus.of(context);
        final bool hasFocus = focusNode.hasFocus;
        return GestureDetector(
          onTap: () => _pushMenu(context),
          child: Container(

            color: hasFocus ? Colors.blue : null,
            child: Text(data),
          ),
        );
      }),
    );
  }
}