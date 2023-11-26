import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:atcho/shared/colors.dart';
import 'package:atcho/shared/ui_helpers.dart';
import 'package:atcho/ui/views/index/index_view.dart';
import 'package:atcho/ui/views/login/login_viewmodel.dart';
import 'package:atcho/ui/views/onboarding/onboarding_view.dart';
import 'package:atcho/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key, this.lang, }) : super(key: key);
  final String? lang;

  @override
  Widget build(BuildContext context) {
    var email = useTextEditingController();
    var password = useTextEditingController();

    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              height: screenHeightPercentage(context, percentage: 1),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  verticalSpaceLarge,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Image.asset("assets/icons/back.png",color: Colors.black).gestures(
                        onTap: () => model.navigateTo(view: const OnBoardingView()),
                      ),
                      const SizedBox(width: 40,),
                    ],
                  ),
                  verticalSpaceSmall,
                  Text("Login".tr(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20)).center(),
                  verticalSpaceRegular,
                  SizedBox(
                    // height: 50,
                    child: TextFormField(
                      validator: (value) => model.validateEmail(value: value),
                      controller: email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "| Enter your Username".tr(),
                        hintStyle: const TextStyle(fontSize: 14, color: kBlackColor),
                        fillColor: Colors.white70,
                        prefixIcon: const Icon(Icons.person),
                        contentPadding: const EdgeInsets.all(1.0),
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kMainColor1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kMainColor1),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceMedium,
                  SizedBox(
                    // height: 50,
                    child: TextFormField(
                      validator: (value) => model.validatePassword(value: value),
                      controller: password,
                      obscureText: model.isObscure,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "| Enter your password".tr(),
                        hintStyle: const TextStyle(fontSize: 14, color: kBlackColor),
                        fillColor: Colors.white70,
                        contentPadding: const EdgeInsets.all(1.0),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: Icon(model.isObscure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined).gestures(
                          onTap: () => model.changeObscure(),
                        ),
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kMainColor1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kMainColor1),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceTiny,
                  Text('Forgot Password?'.tr(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: kMainColor2),)
                      .alignment(Alignment.centerRight),
                  verticalSpaceLarge,
                  verticalSpaceLarge,
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: kMainColor1,
                    ),
                    child: Center(
                      child: model.isClicked! ? const Loader(color: Colors.white,).center() : Text('Next'.tr(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                    ),
                  ).gestures(
                    onTap: model.isClicked! ? () {} : () {
                      if (email.text.isEmpty || password.text.isEmpty) {
                        showMotionToast(
                          context: context,
                          type: MotionToastType.warning,
                          msg: "All fields are mandatory, fill all missing fields".tr(),
                        );
                      } else {
                        model.login(body: {
                          "email": email.text,
                          "password": password.text,
                        }, context: context,).then((value) {
                          model.updateIsClicked(value: false);
                          if (value != null) {
                            model.clearAndNavigateTo(view: const WebSocketListener());
                          }
                        });
                      }
                    },
                  ),
                  verticalSpaceSmall,
                  Text("You haven't an account? Sign Up".tr(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),).center().gestures(
                    onTap: () => model.navigateTo(view: const OnBoardingView()),
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(lang: lang),
    );
  }
}
