import 'package:flutter/material.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/ui/page2.dart';
import 'package:portfolio_creator/widget/camera_widget.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  var nameController = TextEditingController();
  var professionController = TextEditingController();
  var bioController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Portfolio Maker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ), // Custom back icon
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.purple,
        elevation: 5,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _globalKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '1. Personal Details',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Center(
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 5),
                    //       SizedBox(
                    //         height: 140,
                    //         width: MediaQuery.of(context).size.width * 0.7,
                    //         child: CameraWidget(),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height *0.15,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: CameraWidget(),
                      ),
                    ),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: "Enter Your Full Name",
                      icon: Icons.account_circle_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Full Name",
                      onChanged: (value) {
                        setState(() {
                          nameController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Full Name first...";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: professionController,
                      hintText: "Enter Your Profession",
                      icon: Icons.work_outline_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Profession",
                      onChanged: (value) {
                        setState(() {
                          professionController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Full Name first...";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: bioController,
                      maxLines: 2,
                      hintText: "Write a short Bio",
                      icon: Icons.info_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Bio",
                      onChanged: (value) {
                        setState(() {
                          bioController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Bio first...";
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

                    CustomTextFormField(
                      controller: mobileController,
                      hintText: "Enter Your mobile number",
                      icon: Icons.smartphone,
                      keyboardType: TextInputType.text,
                      labelText: "Mobile Number",
                      onChanged: (value) {
                        setState(() {
                          mobileController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Mobile Number first...";
                        }
                        if (value.length < 10) {
                          return "Enter valid Mobile number";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: addressController,
                      hintText: "Enter Your Address",
                      icon: Icons.location_on,
                      keyboardType: TextInputType.text,
                      labelText: "Address",
                      onChanged: (value) {
                        setState(() {
                          addressController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Address first...";
                        }
                        return null;
                      },
                    ),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SocialLinks(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade500,
                          foregroundColor: Colors.white,
                        ),
                        child: Padding(
                          // padding: const EdgeInsets.symmetric(
                          //   horizontal: 130,
                          //   vertical: 10,
                          // ),
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.31,
                            vertical: 10,
                          ),
                          child: Text(
                            "Next Page",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
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
