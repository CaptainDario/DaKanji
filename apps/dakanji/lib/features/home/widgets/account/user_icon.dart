import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class UserIcon extends StatefulWidget {

  final Color color;

  const UserIcon(
    this.color,
    {
      super.key
    }
  );

  @override
  State<UserIcon> createState() => _UserIconState();
}

class _UserIconState extends State<UserIcon> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/ui/user_background.svg",
      width: 64,
      height: 64,
      colorFilter: ColorFilter.mode(
        widget.color,
        BlendMode.srcIn,
      ),
    );
  }
}