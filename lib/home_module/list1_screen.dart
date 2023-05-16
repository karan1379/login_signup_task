import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_task/home_module/home_screen_conroller.dart';
import 'package:login_signup_task/model/image_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class List1Screen extends StatelessWidget {
   List1Screen({Key? key}) : super(key: key);
  final controller = Get.put(HomeScreenController());
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
      body:   Obx(()=>
      controller.imageList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const MaterialClassicHeader(
          color: Colors.black,
        ),
        footer:const ClassicFooter(
          loadingIcon: CupertinoActivityIndicator(
            color: Colors.black,
          ),
          loadStyle: LoadStyle.ShowWhenLoading,
        ),
        controller: _refreshController,
        scrollDirection: Axis.vertical,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (ctx, position) {
            final bodyData = controller.imageList[position];
            return createCard(bodyData);
          },
          itemCount: controller.imageList.length,

        ),
      )
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
