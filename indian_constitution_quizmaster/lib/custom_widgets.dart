import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final Color? titleColor;
  final Function onTap;
  final String optionType, option;

  const OptionTile({
    super.key,
    required this.optionType,
    required this.option,
    required this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.surfaceTint,
      splashFactory: InkRipple.splashFactory,
      borderRadius: BorderRadius.circular(10),
      onTap: () => onTap(),
      child: Container(
        width: double.maxFinite,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: titleColor,
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          "$optionType. $option",
          style: const TextStyle(fontSize: 17.5),
        ),
      ),
    );
  }
}
