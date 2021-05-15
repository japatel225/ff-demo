import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_demo/constants.dart';
import 'package:ff_demo/helper.dart';
import 'package:ff_demo/presentation/widgets/password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  File profileImageFile;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.15),
            Text('Sign up with email', style: bodyTextStyle),
            const SizedBox(height: 20),
            ProfilePic(onImagePicked: (file) => profileImageFile = file),
            const SizedBox(height: 15),
            Material(
              elevation: 4,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Name'),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 15),
            Material(
              elevation: 4,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 15),
            PasswordField(controller: passwordController),
            const SizedBox(height: 25),
            ElevatedButton(child: Text('Sign Up'), onPressed: onSignUpClicked),
            const SizedBox(height: 70),
            Text('Already have an account?', style: bodyTextStyle),
            TextButton(
              child: Text('Login', style: textButtonTextStyle),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void onSignUpClicked() async {
    if (nameController.text.isEmpty) {
      showToast('Please enter name');
      return;
    }

    if (!isValidEmail(emailController.text)) {
      showToast('Please enter valid email');
      return;
    }

    if (passwordController.text.isEmpty) {
      showToast('Please enter password');
      return;
    }

    if (profileImageFile == null) {
      showToast('Please add profile image');
      return;
    }

    showWaitDialog(context);

    try {
      final userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final String userId = userCred.user.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'name': nameController.text});

      await FirebaseStorage.instance
          .ref('users/$userId')
          .putFile(profileImageFile);

      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      //dismiss "please wait..." dialog
      Navigator.of(context).pop();
      showToast(e.message);
    }
  }
}

class ProfilePic extends StatefulWidget {
  final void Function(File file) onImagePicked;

  const ProfilePic({@required this.onImagePicked});

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final picker = ImagePicker();
  File pickedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        radius: 50,
        backgroundColor: themeLightBlueColor,
        backgroundImage: pickedImage != null ? FileImage(pickedImage) : null,
        child: pickedImage == null
            ? Icon(Icons.person, color: Colors.white, size: 35)
            : null,
      ),
      onTap: () async {
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        if (pickedFile != null) {
          widget.onImagePicked(File(pickedFile.path));
          setState(() => pickedImage = File(pickedFile.path));
        }
      },
    );
  }
}
