import 'package:flutter/material.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/ui/myhome_page.dart';
import 'package:portfolio_creator/ui/profile_page.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:portfolio_creator/widget/custom_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.network(
                  "https://img.freepik.com/free-vector/secure-login-concept-illustration_114360-4511.jpg",
                  height: 350,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: [
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
          
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 30,
                          ),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an Account?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                              );
                            },
                            child: Text(
                              " Sign Up",
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
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
}
