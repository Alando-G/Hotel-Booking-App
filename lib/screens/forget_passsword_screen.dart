// ignore_for_file: sort_child_properties_last, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_signup/screens/signin_screen.dart';
import '../theme/theme.dart'; 

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: lightColorScheme.primary,
          ),
        ),
        backgroundColor: lightColorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Enter your email to reset your password',
              style: TextStyle(
                fontSize: 18,
                color: lightColorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: lightColorScheme.onBackground,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: lightColorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => const SignInScreen()),
                 );
              },
              child: Text(
                'Send',
                style: TextStyle(
                  fontSize: 18,
                  color: lightColorScheme.onPrimary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: lightColorScheme.onPrimary, backgroundColor: lightColorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}