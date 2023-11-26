import 'package:easy_localization/easy_localization.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:atcho/shared/colors.dart';
import 'package:atcho/shared/ui_helpers.dart';
import 'package:atcho/ui/widgets/dot_item.dart';

// ignore: must_be_immutable
class OnBoarding1 extends StatelessWidget {
  OnBoarding1({Key? key, this.passer, this.onTap, this.login, this.usersCount}) : super(key: key);
  final Function()? onTap;
  final Function()? login;
  final Function()? passer;
  dynamic usersCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/1.png'),
          fit: BoxFit.cover,
        )
      ),
      height: screenHeightPercentage(context, percentage: 1),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          verticalSpaceLarge,
          Text('Welcome to Atcho\nWhere Rewards Meet Revelry!'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20,), textAlign: TextAlign.center),
          verticalSpaceMedium,
          Text("! Atcho's your VIP pass to unlocking hidden treasures, exclusive promotions, and more. Ready to embark on a digital pub crawl like never before?".tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700,), textAlign: TextAlign.center),
          verticalSpaceRegular,
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotItem(condition: true,),
              horizontalSpaceSmall,
              DotItem(condition: false,),
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
            onTap: login!(),
          ),
          verticalSpaceMedium,
        ],
      ),
    );
  }
}