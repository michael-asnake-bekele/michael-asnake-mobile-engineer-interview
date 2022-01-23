import 'package:flutter/material.dart';
/// creates a custom Appbar
AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    toolbarHeight: 72,
    flexibleSpace: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 16,left: 40),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VerticalDivider(
                color: Colors.grey[800],
                thickness: 2.5,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'S  A  M  A  S  Y  S',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  Text(
                      'combat salary fraud',
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
