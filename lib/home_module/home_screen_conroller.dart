import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup_task/helper/routes/routes.dart';
import 'package:login_signup_task/helper/shared_prefrence_helper.dart';
import 'package:login_signup_task/model/image_model.dart';
import 'package:login_signup_task/utils/api_constants.dart';

class HomeScreenController extends GetxController {

  Dio dio = Dio();
  var salePageOffset = 0.obs;
  var salePageLimit = 10;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<ImageModel> imageList = RxList();
  late SharedPreferenceHelper preferenceHelper;
  @override
  void onInit() {
    super.onInit();
    preferenceHelper=SharedPreferenceHelper();
    getList();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  Future<List<ImageModel>?> getList() async {
    try {
      Map<String, dynamic> queries = HashMap();
      queries["limit"] = salePageLimit;
      queries["page"] = salePageOffset.value;
      final response = await dio.get(
          ApiConstants.picsumBaseUrl, queryParameters: queries);
      if (response.statusCode == 200) {
        imageList.value =
            (response.data as List).map((p) => ImageModel.fromJson(p)).toList();
        print(imageList.value);
      } else {
        Get.showSnackbar(const GetSnackBar(message: "Error",));
      }
    } catch (e) {
      print(e);
    }
  }

  Future getListPagination() async {
    try {
      salePageOffset.value = salePageOffset.value + 1;
      Map<String, dynamic> queries = HashMap();
      queries["limit"] = salePageLimit;
      queries["page"] = salePageOffset.value;
      final response = await dio.get(ApiConstants.picsumBaseUrl, queryParameters: queries,
        //   options: Options(
        // headers: ,)
    );
      if (response.statusCode == 200) {
        imageList.value = (response.data as List).map((p) => ImageModel.fromJson(p)).toList();
        print(imageList.value);
      } else {
        Get.showSnackbar(const GetSnackBar(message: "Error",));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> googleLogout() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _googleSignIn.signOut();
      Get.offAllNamed(Routes.login);
      preferenceHelper.clearAll();
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    try {
      Get.offAllNamed(Routes.login);
      preferenceHelper.clearAll();
    } catch (error) {
      print(error);
    }
  }
}
