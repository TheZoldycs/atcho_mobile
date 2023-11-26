import 'package:atcho/shared/colors.dart';
import 'package:atcho/shared/ui_helpers.dart';
import 'package:atcho/ui/views/navbar/people/people_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

class PeopleView extends HookWidget {
  const PeopleView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PeopleViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/icons/back.png"),
                      const Text('PEOPLE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, ),),
                      Image.asset("assets/icons/notifications.png"),
                    ],
                  ),
                  verticalSpaceRegular,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(4, (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            spreadRadius: 1,
                            blurRadius: 12
                          )
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/icons/people${index + 1}.png"),
                          horizontalSpaceSmall,
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(model.staticPeople[index], style: const TextStyle(fontWeight: FontWeight.w600),),
                                  horizontalSpaceTiny,
                                  const Text("Level 05", style: TextStyle(color: kMainColor1),),
                                ],
                              ),
                              const Text("Close 4 meters",),
                            ],
                          ),
                          const Spacer(),
                          const Text("Track", style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xff0070F0)),),
                          horizontalSpaceSmall,
                        ],
                      ),
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PeopleViewModel(context: context),
    );
  }
}