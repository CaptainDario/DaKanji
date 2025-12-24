import 'package:da_kanji_mobile/features/home/widgets/account/user_icon.dart';
import 'package:flutter/material.dart';


class UserIconEditor extends StatefulWidget {

  final double width;
  
  final double height;

  final Color avatarColor;

  final String avatarCharacter;

  final Color avatarCharacterColor;

  final Function() onAvatarColorPickerPressed;

  final Function() onAvatarCharacterColorPickerPressed;

  const UserIconEditor(
    {
      this.width = 64,
      this.height = 64,
      required this.avatarColor,
      required this.avatarCharacter,
      required this.avatarCharacterColor,
      required this.onAvatarColorPickerPressed,
      required this.onAvatarCharacterColorPickerPressed,
      super.key
    }
  );

  @override
  State<UserIconEditor> createState() => _UserIconEditorState();
}

class _UserIconEditorState extends State<UserIconEditor> {
  @override
  Widget build(BuildContext context) {

    final double colorPickerWidth = widget.width / 4;
    final double colorPickerHeight = widget.height / 4;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            UserIcon(
              width: widget.width,
              height: widget.height,
              avatarColor: widget.avatarColor,
              avatarCharacter: widget.avatarCharacter,
              avatarCharacterColor: widget.avatarCharacterColor,
            ),
            Positioned(
              left: -widget.width/12,
              bottom: -widget.height/12,
              child: _ColorPickerButton(
                width: colorPickerWidth,
                height: colorPickerHeight,
                pickerColor: widget.avatarCharacterColor,
                onPressed: widget.onAvatarCharacterColorPickerPressed
              ),
            ),
              
            Positioned(
              right: -widget.width/12,
              bottom: -widget.height/12,
              child: _ColorPickerButton(
                width: colorPickerWidth,
                height: colorPickerHeight,
                pickerColor: widget.avatarColor,
                onPressed: widget.onAvatarColorPickerPressed
              ),
            )
          ],
        ),
      ],
    );
  }
}


class _ColorPickerButton extends StatelessWidget {

  final double width;

  final double height;

  final Color pickerColor;

  final Function()? onPressed;

  const _ColorPickerButton(
    {
      this.width = 24,
      this.height = 24,
      required this.pickerColor,
      this.onPressed,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 0,
            spreadRadius: 2
          ),
        ],
      ),
      child: Material(
        color: pickerColor,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 1.5
          )
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}