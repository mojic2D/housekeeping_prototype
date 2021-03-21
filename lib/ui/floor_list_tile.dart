import 'package:flutter/material.dart';

class FloorListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          child: Text("001"),
        ),
      ),
    );
  }
}
