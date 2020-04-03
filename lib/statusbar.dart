import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  double _width, _height;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Container(
              color: Colors.black,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("$_width x $_height")
                  ),
                  Expanded(
                    child: Text(
                      "piPod",
                      textAlign: TextAlign.center,
                      ),
                  ),
                  Expanded(
                    child: Container()
                  )
                ]
              ),
            );
  }
}