import 'package:ff_demo/constants.dart';
import 'package:ff_demo/presentation/screens/register_screen.dart';
import 'package:ff_demo/presentation/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
            SizedBox(height: screenHeight * 0.25),
            Text('Login with email', style: bodyTextStyle),
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
            TextButton(
              child: Text('Forgot Password?', style: textButtonTextStyle),
              onPressed: null,
            ),
            const SizedBox(height: 5),
            ElevatedButton(child: Text('Login'), onPressed: () {}),
            const SizedBox(height: 100),
            Text('Don\'t have an account?', style: bodyTextStyle),
            TextButton(
              child: Text('Sign Up', style: textButtonTextStyle),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RegisterScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
