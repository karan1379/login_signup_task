
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_task/home_module/home_screen_conroller.dart';
import 'package:login_signup_task/home_module/list1_screen.dart';
import 'package:login_signup_task/home_module/list2_screen.dart';
import 'package:login_signup_task/home_module/list3_screen.dart';
import 'package:login_signup_task/model/image_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({Key? key}) : super(key: key);
  final controller = Get.put(HomeScreenController());
  var isShown=true.obs;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() {
    Future.delayed(const Duration(milliseconds: 1000)).then((val) async {
      controller.salePageOffset.value = 0;
      await controller.getListPagination();
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() {
    Future.delayed(const Duration(milliseconds: 1000)).then((val) async {
      await controller.getListPagination();
      _refreshController.loadComplete();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: controller.scaffoldKey,
      appBar: AppBar(
        actions:  [
          Container(
              alignment:Alignment.center ,
              child: InkWell(
                  onTap: (){
                    controller.logout();
                  },
                  child: Text("Logout"))),
        ],
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 45,
            child: TabBar(
              controller: controller.homeTabController,
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 8),
              labelPadding: EdgeInsets.symmetric(horizontal: 30),
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              tabs:
              [
                Tab(child: Text(
                  "List1",
                  style: TextStyle(fontSize: 14),
                ),),
                Tab(
                  child: Text(
                    "List2",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Tab(
                  child: Text(
                    "List3",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ] ,
              onTap: (index) {
                if (index == 0) {
                  isShown.value=true;
                }
                if (index == 1) {
                  isShown.value=true;
                }
                if (index == 2) {
                  isShown.value=true;
                }
                if (index == 3) {
                  isShown.value=false;
                }
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
                controller: controller.homeTabController,
                children: [
                  // HomeProductScreen(),
                  // HomeServiceScreen(),
                  // HomeEventScreen(),
                  List1Screen(),
                  List2Screen(),
                  List3Screen()
                ]),
          )
        ],
      ),





    );
  }
  Widget createCard(ImageModel bodyData) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 80,
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              CachedNetworkImage(
                imageUrl:bodyData.downloadUrl??"",
                imageBuilder: (context, imageProvider)=>
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) =>
                    Container(
                      decoration:const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("as"),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      color: const Color(0x80000000),
                      padding: const EdgeInsets.all(5),
                      child: Text("${bodyData.author}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600),
                      ))
              )],
          ),
        ),
      ),
    );
  }


}
