import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_task/authentication_module/controller/authentication_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  AuthController controller =Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   leading: IconButton(icon:Icon(Icons.arrow_back),onPressed:(){
      //     Get.back();
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(
                 margin: EdgeInsets.only(bottom: 30),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   IconButton(onPressed:()=>Get.back(), icon:Icon(Icons.arrow_back)),
                  const  Text("Signup",textAlign: TextAlign.center,
                      style:TextStyle(
                        color: Colors.blue,
                        fontSize: 35,
                        fontWeight: FontWeight.w700
                    ),),
                    const SizedBox(width: 0,height: 0,)
                 ],),
               ),
              commonTextField(nameController,"Enter Name"),
              const SizedBox(height: 20,),
              commonTextField(emailController,"Enter Email"),
              const SizedBox(height: 20,),
              commonTextField(passwordController,"Enter Password"),

              InkWell(
                onTap: (){
                  // Get.back();
                  // controller.googleLogin();
                  controller.addStudent(nameController.text, emailController.text.trim(), passwordController.text.trim());

                },
                child: Container(
                  decoration:const BoxDecoration(
                      color: Colors.blue
                  ),
                  margin:const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
                  padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      Text("Sign Up"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonTextField(TextEditingController controller,String hintText){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),      child: TextFormField(
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
