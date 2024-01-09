import 'dart:io';

import 'package:chat_app_with_firebase/add_Image/add_image.dart';
import 'package:chat_app_with_firebase/pallet/pallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInAndUpScreen extends StatefulWidget {
  const SignInAndUpScreen({super.key});

  @override
  State<SignInAndUpScreen> createState() => _SignInAndUpScreenState();
}

class _SignInAndUpScreenState extends State<SignInAndUpScreen> {
  final authentication = FirebaseAuth.instance;
  bool showSpinner = false;
  bool isSignUP = true;
  String userName = '';
  String userEmail = '';
  String userPwd = '';
  File? userPickedImage;
  final _formKey = GlobalKey<FormState>();
  void pickedImage(File image) {
    userPickedImage = image;
  }

  // 입력폼을 활용해 입력값을 받기 위한 메서드
  void tryVali() {
    // 폼 필드 내 validator를 기능하기 위한 메서드
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      // onSaved 메서드를 실행하기 위한 메서드
      _formKey.currentState!.save();
    }
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: AddImage(addImageFunc: pickedImage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: GestureDetector(
        onTap: () {
          // 현재 포커스를 찾는 클래스인듯
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // Bgcolor
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Palette.googleColor,
              ),
            ),
            // Image
            const Positioned(
              top: 40,
              right: 10,
              child: Image(
                width: 70,
                image: AssetImage('images/duckWithdog.png'),
              ),
            ),
            // Navigator
            Positioned(
              top: 90,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      isSignUP
                          ? Text(
                              ' to Y&L App',
                              style: Theme.of(context).textTheme.displayLarge,
                            )
                          : Text(
                              ' Back Y&L App',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                    ],
                  ),
                  isSignUP
                      ? Text(
                          'Sign Up to continue ',
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      : Text(
                          'Sign In to continue ',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                ],
              ),
            ),
            // TextForm
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 180, 15, 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  width: MediaQuery.of(context).size.width - 40,
                  height: isSignUP ? 300 : 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(5, 7),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUP = false;
                                });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSignUP
                                            ? Palette.textColor1
                                            : Palette.activeColor),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 2,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUP = true;
                                });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSignUP
                                              ? Palette.activeColor
                                              : Palette.textColor1,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      if (isSignUP)
                                        GestureDetector(
                                          onTap: () {
                                            showAlert(context);
                                          },
                                          child: Icon(
                                            Icons.image,
                                            color: isSignUP
                                                ? Colors.cyan
                                                : Colors.grey[300],
                                          ),
                                        )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 35,
                                    ),
                                    width: 55,
                                    height: 2,
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        isSignUP
                            // SignUp
                            ? Container(
                                padding: const EdgeInsets.all(15),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (value) {
                                          userName = value;
                                        },
                                        onSaved: (newValue) {
                                          userName = newValue!;
                                        },
                                        key: const ValueKey(1),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 4) {
                                            return '최소한 4글자의 이름이 필요합니다.';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'User name',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          prefixIcon: Icon(
                                            Icons.account_circle,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (value) {
                                          userEmail = value;
                                        },
                                        onSaved: (newValue) {
                                          userEmail = newValue!;
                                        },
                                        key: const ValueKey(2),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !(value.contains('@'))) {
                                            return '이메일 형식을 입력해주세요';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'email',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (value) {
                                          userPwd = value;
                                        },
                                        onSaved: (newValue) {
                                          userPwd = newValue!;
                                        },
                                        key: const ValueKey(3),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return '6글자 이상의 비밀번호가 필요합니다.';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          hintText: 'password',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          prefixIcon: Icon(
                                            Icons.password,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            // SignIn
                            : Container(
                                padding: const EdgeInsets.all(15),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (value) {
                                          userEmail = value;
                                        },
                                        onSaved: (newValue) {
                                          userEmail = newValue!;
                                        },
                                        key: const ValueKey(4),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !(value.contains('@'))) {
                                            return '이메일 형식을 입력해주세요';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'email',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        onChanged: (value) {
                                          userPwd = value;
                                        },
                                        onSaved: (newValue) {
                                          userPwd = newValue!;
                                        },
                                        key: const ValueKey(5),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return '6글자 이상의 비밀번호가 필요합니다.';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'password',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          prefixIcon: Icon(
                                            Icons.password,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                35,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // 전송버튼
            AnimatedPositioned(
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.easeIn,
              top: isSignUP ? 453 : 410,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (isSignUP) {
                        if (userPickedImage == null) {
                          setState(() {
                            showSpinner == false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('please check your profile image'),
                                backgroundColor: Colors.red),
                          );
                          return;
                        }
                        tryVali();
                        try {
                          final newUser = await authentication
                              .createUserWithEmailAndPassword(
                                  email: userEmail, password: userPwd);
                          final refImage = FirebaseStorage.instance
                              .ref()
                              .child('picked_image')
                              .child('${newUser.user!.uid}.png');
                          await refImage.putFile(userPickedImage!);
                          final url = await refImage.getDownloadURL();
                          await FirebaseFirestore.instance
                              .collection('user')
                              .doc(newUser.user!.uid)
                              .set(
                            {
                              'userName': userName,
                              'userEmail': userEmail,
                              'picked_image': url,
                            },
                          );
                          setState(
                            () {
                              showSpinner = false;
                            },
                          );
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                          await Future.delayed(const Duration(seconds: 3), () {
                            return ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'please check your Email and Password'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          });
                          setState(
                            () {
                              showSpinner = false;
                            },
                          );
                        }
                      } else {
                        tryVali();
                        try {
                          final newUser =
                              await authentication.signInWithEmailAndPassword(
                                  email: userEmail, password: userPwd);
                          if (newUser.user != null) {}
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                          if (mounted) {
                            await Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'please check your Email and Password'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              },
                            );
                            setState(
                              () {
                                showSpinner = false;
                              },
                            );
                          }
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.red,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(1, 3)),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Sign up With google
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: isSignUP
                  ? MediaQuery.of(context).size.height - 255
                  : MediaQuery.of(context).size.height - 325,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(isSignUP ? 'or Sign Up with' : 'or Sing In with'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                        155,
                        40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Palette.googleColor,
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Google'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
