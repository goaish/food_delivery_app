import 'package:flutter/material.dart';

import 'or_divider.dart';
import 'social_icon.dart';



class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialIcon(
              iconSrc: "assets/icons/facebook.png",
              press: () {},
            ),
            SocialIcon(
              iconSrc: "assets/icons/twitter.png",
              press: () {},
            ),
            SocialIcon(
              iconSrc: "assets/icons/google_plus.png",
              press: () {},
            ),
          ],
        ),
      ],
    );
  }
}