import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:login_signup_task/helper/routes/routes.dart';
import 'package:login_signup_task/helper/shared_prefrence_helper.dart';
import 'package:login_signup_task/model/user_model.dart';
import 'package:login_signup_task/utils/utils.dart';

class AuthController extends GetxController{

  late SharedPreferenceHelper preferenceHelper;
  CollectionReference students = FirebaseFirestore.instance.collection('users');
  RxList<UserModel> usersList = RxList();

  @override
  void onInit() {
    // TODO: implement onInit
    preferenceHelper=SharedPreferenceHelper();
    super.onInit();
  }


  Future<void> addStudent(String fullName,String email,String password) {
    // Calling the collection to add a new user
    return students
    //adding to firebase collection
        .add({
      //Data added in the form of a dictionary into the document.
      'name': fullName,
      'email': email,
      'password': password
    })
        .then((value) {
      print("Student data Added");
      Get.offAllNamed(Routes.home);
      preferenceHelper.saveIsLoggedIn(true);


    })
        .catchError((error) => print("Student couldn't be added."));
  }

  Future<void> getStudent() {
    // Calling the collection to add a new user
    return students.get().then((value) {

      final allData = value.docs.map((doc) => doc.data()).toList();
            List<dynamic> list = allData;
            usersList.clear();
            for (var element in list) {
              usersList.add(UserModel.fromJson(element as Map<String, dynamic>));
            }

      // void getAllUsers() async {
      //   if (await Utils.hasNetwork()) {
      //     final first = databaseUserPath.orderBy('name').limit(5);
      //     first.get().then((documentSnapshots) {
      //       lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
      //       final allData = documentSnapshots.docs.map((doc) => doc.data()).toList();
      //       List<dynamic> list = allData;
      //       usersList.clear();
      //       for (var element in list) {
      //         usersList.add(UserModel.fromJson(element as Map<String, dynamic>));
      //       }
      //       for (int i = 0; i < usersList.length; i++) {
      //         if (usersList[i].uid == SharedPreferenceHelper().getUserId()) {
      //           usersList.remove(usersList[i]);
      //         }
      //       }
      //       for (int i = 0; i < usersList.length; i++) {
      //         for (var element in blockUsersList) {
      //           if (usersList[i].uid == element.uid ||
      //               usersList[i].uid == element.blockedBy) {
      //             usersList.remove(usersList[i]);
      //             usersList.refresh();
      //           }
      //         }
      //       }
      //
      //       usersList.refresh();
      //     });
      //   }
      // }
    })
        .catchError((error) => print("Student couldn't be added."));
  }

  Future<void> login(String email,String password)async {
    Utils.showLoader();

    for(var item in usersList){
      if(email==item.email && password ==  item.password){
        preferenceHelper.saveIsLoggedIn(true);
        Utils.hideLoader();
        Get.offAllNamed(Routes.home);
      }else{
        Utils.hideLoader();
       Get.showSnackbar(GetSnackBar(message: "No User Found",));
      }
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