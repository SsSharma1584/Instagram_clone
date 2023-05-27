import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/firebase/auth_methods.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/Round Button.dart';
import 'package:instagram/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/Utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  Uint8List? _image;
  bool loading = false;



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
    usernameController.dispose();
    bioController.dispose();
  }

  void selectImage()async{
  Uint8List im=  await pickImage(ImageSource.gallery);
  setState(() {
    _image=im;
  });
  }

  void signUpUser()async{
    setState(() {
      loading=true;
    });
      String res= await AuthMethods().signUpUser(
        email: emailController.text,
        password: passController.text,
        username: usernameController.text,
        bio: bioController.text,
        file: _image!,
      );
      setState(() {
        loading=false;
      });

      if(res != 'Success'){
     showSnackBar(context, res);
    }else{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout()
          ),
            )
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: Container(),
                        ),
                        SvgPicture.asset(
                          'assets/instagram.svg',
                          color: primaryColor,
                          height: 120,
                        ),
                        Stack(
                            children: [
                              _image!=null ?
                                  CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                             : const CircleAvatar(
                                backgroundImage: AssetImage('assets/user.png'),
                                radius: 60,
                              ),
                              Positioned(
                                  bottom: -10,
                                  left: 80,
                                  child: IconButton(
                                      onPressed: () {
                                        selectImage();
                                      },
                                      icon: const Icon(
                                        Icons.add_a_photo,
                                        size: 31,
                                      )))
                            ],
                          ),
                         const SizedBox(
                          height: 24,
                        ),
                         TextFieldInput(
                            textEditingController: usernameController,
                            hintText: 'Username',
                            textInputType: TextInputType.text,
                          ),
                        const SizedBox(
                          height: 24,
                        ),
                         TextFieldInput(
                            textEditingController: emailController,
                            hintText: 'Email',
                            textInputType: TextInputType.emailAddress,
                          ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                            textEditingController: passController,
                            hintText: 'Password',
                            textInputType: TextInputType.visiblePassword,
                            isPass: true,
                          ),
                        const SizedBox(
                          height: 24,
                        ),
                         TextFieldInput(
                            textEditingController: bioController,
                            hintText: 'Bio',
                            textInputType: TextInputType.text,
                          ),
                        const SizedBox(
                          height: 24,
                        ),
                         RoundButton(
                           loading: loading,
                              title: 'Sign in',
                              onTap: signUpUser
                         ),
                        const SizedBox(
                          height: 140,
                        ),
                      ]),
                ))));
  }
}
