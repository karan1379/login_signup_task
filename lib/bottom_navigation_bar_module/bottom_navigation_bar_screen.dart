import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_task/bottom_navigation_bar_module/bottom_navigation_bar_controller.dart';
import 'package:login_signup_task/home_module/home_screen.dart';
import 'package:login_signup_task/order_module/order_screen.dart';
import 'package:login_signup_task/profile_module/profile_screen.dart';

class BottomNavigationBarScreen extends StatelessWidget {
   BottomNavigationBarScreen({Key? key}) : super(key: key);

  BottomNavigationBarController controller=Get.put(BottomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Column(
        children: [
          Obx(() => Expanded(
            child: IndexedStack(
              index: controller.bottomBarIndex.value,
              children: [
                HomeScreen(),
                OrderScreen(),
                ProfileScreen(),
              ],
            ),
          )),
          bottomNavigationBarWidget(),
        ],
      ),
    );
  }
  bottomNavigationBarWidget() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: 6, left: 20, right: 20),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
                () => InkWell(
              child: controller.bottomBarIndex.value == 0
                  ? Column(
                children: const [
                  Icon(Icons.home),
                  SizedBox(height: 4),
                  Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              )
                  : Column(
                children: const [
                 Icon(Icons.home_filled),
                  SizedBox(height: 4),
                  Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                ],
              ),
              onTap: () async {
                controller.changeTabIndex(0);
              },
            ),
          ),
          Obx(
                () => InkWell(
              child: controller.bottomBarIndex.value == 1
                  ? Column(
                children: const [
                  Icon(Icons.food_bank,),
                  SizedBox(height: 7),
                  Text(
                    "Order",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              )
                  : Column(
                children: const [
                  Icon(Icons.food_bank_outlined,),
                  SizedBox(height: 7),
                  Text(
                    "Order",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
              onTap: () {
                controller.changeTabIndex(1);

              },
            ),
          ),
          Obx(
                () => InkWell(
              child: controller.bottomBarIndex.value == 3
                  ? Column(
                children:const [
                  Icon(Icons.person),
                  SizedBox(height: 7),
                  Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              )
                  :
              Column(
                children: const [
                  Icon(Icons.person_2_outlined),
                  SizedBox(height: 7),
                  Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
              onTap: () {
                controller.changeTabIndex(2);
              },
            ),
          ),
        ],
      ),
    );
  }
}
