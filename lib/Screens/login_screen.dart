import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/Screens/signup_screen.dart';
import 'package:instagram/firebase/auth_methods.dart';
import 'package:instagram/utils/Utils.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/text_field_input.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import 'package:instagram/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool loading = false;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void loginUser()async{
    setState(() {
      loading=true;
    });
    String res = await AuthMethods().loginUser(email: emailController.text, password: passController.text
    );
    setState(() {
      loading=false;
    });
    if(res == "success"){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout()
            ),
          )
      );
    }else{
      showSnackBar(context, res);
    }setState(() {
        loading=false;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: SafeArea(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(flex: 1,child: Container(),),
                          SvgPicture.asset(
                            'assets/instagram.svg',
                            color: primaryColor,
                            height: 120,
                          ),
                          const SizedBox(height: 64,),
                          TextFieldInput(
                              textEditingController: emailController,
                              hintText: 'Email',
                              textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 24,),
                          TextFieldInput(
                              textEditingController: passController,
                              hintText: 'Password',
                              textInputType: TextInputType.visiblePassword,
                            isPass: true,
                          ),
                          const SizedBox(height: 24,),
                          RoundButton(
                              loading: loading,
                              title: 'Log in',
                              onTap: loginUser
                          ),
                          const SizedBox(height: 12,),
                          Flexible(flex: 1,child: Container(),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                    "Don't have an account?"),

                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen(),));
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                ),
                              ),
                            ],
                          ),
                           const SizedBox(height: 12,),
                        ]
                    )
                )
            )
        );
  }
}

