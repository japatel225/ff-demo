import 'package:ff_demo/constants.dart';
import 'package:ff_demo/presentation/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            CircleAvatar(
              radius: 50,
              backgroundColor: themeLightBlueColor,
              child: Icon(Icons.person, color: Colors.white, size: 35),
            ),
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
            ElevatedButton(child: Text('Sign Up'), onPressed: () {}),
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
}
