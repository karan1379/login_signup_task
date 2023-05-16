import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController{
  var bottomBarIndex = 0.obs;


  changeTabIndex(int index) {
    bottomBarIndex.value = index;
    update();
  }
}