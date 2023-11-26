import 'package:atcho/enum/bottom_sheet_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.basic: (context, sheetRequest, completer) =>
        Container(),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
