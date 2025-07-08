import 'package:flutter/material.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/ui/login_page.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:portfolio_creator/widget/custom_password.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            ClipRRect(
              child: Image.network(
                "https://img.freepik.com/free-vector/sign-up-concept-illustration_114360-7875.jpg?semt=ais_hybrid&w=740",
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: usernameController,
                      hintText: "Enter Your Username",
                      icon: Icons.account_circle_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Username",
                      onChanged: (value) {
                        setState(() {
                          usernameController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Username first...";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Enter Your Email",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Email",
                      onChanged: (value) {
                        setState(() {
                          emailController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Email first...";
                        }
                        if (!emailRegex.hasMatch(value)) {
                          return "Enter valid Email";
                        }
                        return null;
                      },
                    ),

                    CustomPassword(
                      controller: passwordController,
                      hintText: "Enter Your Password",
                      icon: Icons.lock_outline,
                      keyboardType: TextInputType.text,
                      labelText: "Password",
                      onChanged: (value) {
                        setState(() {
                          passwordController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Password first...";
                        }
                        if (!passwordRegExp.hasMatch(value)) {
                          return "Enter valid Password";
                        }
                        return null;
                      },
                    ),

                    CustomPassword(
                      controller: confirmPasswordController,
                      hintText: "Re-enter Your Password",
                      icon: Icons.lock_reset_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Confirm Password",
                      onChanged: (value) {
                        setState(() {
                          confirmPasswordController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != passwordController.text) {
                          return "Enter the correct Password";
                        }
                        if (!passwordRegExp.hasMatch(value)) {
                          return "Enter valid Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.purple.shade400,
                        foregroundColor: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 30,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Already have an Account? LogIn',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
