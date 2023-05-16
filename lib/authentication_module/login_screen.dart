import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_task/authentication_module/controller/authentication_controller.dart';
import 'package:login_signup_task/helper/routes/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key){
    controller.getStudent();
  }
   AuthController controller =Get.put(AuthController());
   TextEditingController emailController =TextEditingController();
   TextEditingController passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Text("Login",style:TextStyle(
             color: Colors.blue,
             fontSize: 35,
             fontWeight: FontWeight.w700
           ),),
           SizedBox(
             height: 20,
           ),
           commonTextField(emailController,"Enter Email"),
          const SizedBox(height: 20,),
           commonTextField(passwordController,"Enter Password"),
           InkWell(
             onTap: (){
              controller.login(emailController.text.trim(), passwordController.text.trim());
             },
             child: Container(
               decoration:const BoxDecoration(
                   color: Colors.blue
               ),
               margin:const  EdgeInsets.symmetric(vertical: 30,horizontal: 20),
               padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
               child:Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:const [
                    Text("Sign In",style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),),
                 ],
               ),
             ),
           ),
           Container(
             margin:const EdgeInsets.only(right: 20),
               alignment: Alignment.bottomRight,
               child:const Text("Forgot Password",style: TextStyle(
                 color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14
               ),)),

           InkWell(
             onTap: (){
               Get.toNamed(Routes.signup);
             },
             child: Container(
               margin:const  EdgeInsets.symmetric(vertical: 50,horizontal: 20),
               padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:const [
                   Text("Sign Up",style: TextStyle(
                     fontSize: 18,
                     color: Colors.blue,
                     fontWeight: FontWeight.w500
                   ),),
                 ],
               ),
             ),
           ),
         ],
       ),
    );
  }

  Widget commonTextField(TextEditingController controller,String hintText){
     return Container(
       margin: EdgeInsets.only(left: 20,right: 20),
       child: TextFormField(
          controller: controller,
         decoration: InputDecoration(
           hintText:hintText,
           border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
           ),
             enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10)
             ),
             focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10)
             )
         ),
       ),
     );
  }
}
