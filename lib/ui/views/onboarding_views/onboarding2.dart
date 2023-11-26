import 'package:easy_localization/easy_localization.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:atcho/shared/colors.dart';
import 'package:atcho/shared/ui_helpers.dart';
import 'package:atcho/ui/widgets/dot_item.dart';

// ignore: must_be_immutable
class OnBoarding2 extends StatelessWidget {
  OnBoarding2({Key? key, this.onTap, this.passer, this.login, this.usersCount}) : super(key: key);
  final Function()? onTap;
  final Function()? login;
  final Function()? passer;
  dynamic usersCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/2.png"),
            fit: BoxFit.cover,
          ),
      ),
      height: screenHeightPercentage(context, percentage: 1),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          verticalSpaceLarge,
          Text('Spotlight on Your Scans!'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
          verticalSpaceMedium,
          Text("Time to shine the light on those rewards! With your camera active, scan your surroundings for exclusive deals. It's like finding the hidden gems in your favorite pub, only tastier!".tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700,), textAlign: TextAlign.center),
          verticalSpaceRegular,
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotItem(condition: false,),
              horizontalSpaceSmall,
              DotItem(condition: true,),
              horizontalSpaceSmall,
              DotItem(condition: false,),
            ],
          ),
          verticalSpaceRegular,
          Container(
            width: MediaQuery.of(context).size.width - 60,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: kMainColor1,
            ),
            child: Center(
              child: Text('Next'.tr(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
            ),
          ).gestures(
              onTap: onTap!()
          ),
          verticalSpaceSmall,
          Text('You have already an account? Sign In'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),).gestures(
            onTap: login!()
          ),
          verticalSpaceMedium,
        ],
      ),
    );
  }
}
