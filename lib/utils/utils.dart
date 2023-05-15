import 'package:flutter_easyloading/flutter_easyloading.dart';

class Utils {
  static showLoader() {
    EasyLoading.show(
      status: "Please Wait...",
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static Future hideLoader() async {
    return await EasyLoading.dismiss();
  }
}
