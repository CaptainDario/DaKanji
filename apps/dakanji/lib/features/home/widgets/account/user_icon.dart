import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class UserIcon extends StatefulWidget {

  final double width;

  final double height;

  final Color avatarColor;

  final String avatarCharacter;

  final Color avatarCharacterColor;

  const UserIcon(
    {
      this.width = 64,
      this.height = 64,
      required this.avatarColor,
      required this.avatarCharacter,
      required this.avatarCharacterColor,
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
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/ui/user_background.svg",
          width: widget.width,
          height: widget.height,
          colorFilter: ColorFilter.mode(
            widget.avatarColor,
            BlendMode.srcIn,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.85,
              heightFactor: 0.85,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  widget.avatarCharacter,
                  style: TextStyle(
                    color: widget.avatarCharacterColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "kouzan",
                    fontSize: 10000
                  ),
                )
              ),
            ),
          ),
        )
      ],
    );
  }
}