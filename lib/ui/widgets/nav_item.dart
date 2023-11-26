import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:atcho/shared/colors.dart';
import 'package:atcho/shared/ui_helpers.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.image,
    required this.isSelected,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: isSelected ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              if (isSelected)...[
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/selected.svg"),
                    Positioned(
                      top: 12,
                      child: SvgPicture.asset(image, color: isSelected ? kMainColor1 : kBlackColor,),
                    ),
                  ],
                ),
              ] else ...[
                SvgPicture.asset(image, color: isSelected ? kMainColor1 : kBlackColor,),
              ],
              verticalSpaceTiny,
              Text(label, style: TextStyle(color: isSelected ? kMainColor1 : kBlackColor,),),
            ],
          ),
        ),
      ),
    );
  }
}