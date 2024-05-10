import 'package:flutter/material.dart';

class FlexSearchBar extends StatelessWidget {
  const FlexSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: kToolbarHeight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: SearchBar(
          trailing: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            )
          ],
        ),
      ),
    );
  }
}
