import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_task/authentication_module/controller/authentication_controller.dart';
import 'package:login_signup_task/utils/utils.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  AuthController controller =Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
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
                     IconButton(
                         onPressed:()
                         {
                           nameController.clear();
                           emailController.clear();
                           passwordController.clear();
                            Get.back();
                         }, icon:Icon(Icons.arrow_back)),
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
                    if(nameController.text.isEmpty){
                      Utils.errorSnackBar("Please enter name");
                      return;
                    }
                    if(emailController.text.trim().isEmpty){
                      Utils.errorSnackBar("Please Enter Email");
                      return;
                    }
                    if(!Utils.emailValidation(emailController.text)){
                      Utils.errorSnackBar("Please Enter valid Email");
                      return;
                    }
                    if(passwordController.text.isEmpty){
                      Utils.errorSnackBar("Please Enter Password");
                      return;
                    }
                    if(passwordController.text.length<8){
                      Utils.errorSnackBar("Password must be minimum of 8 digits");
                      return;
                    }
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
