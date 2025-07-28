// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_creator/models/profile_data_model.dart';
import 'package:portfolio_creator/provider/profile_data_provider.dart';
//import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:portfolio_creator/ui/view_profile.dart';
//import 'package:portfolio_creator/widget/camera_widget.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:provider/provider.dart';

class UpdateData extends StatefulWidget {
  final int? id;

  const UpdateData({super.key, required this.id});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final bioController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final linkedInController = TextEditingController();
  final githubController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final projectTitleController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  final projectTechstackController = TextEditingController();
  final projectUrlController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  ProfileDataModel? _profile;
  bool _isLoading = true;

  int providerId = 0;

  @override
  void initState() {
    super.initState();
    getDataById(widget.id ?? 0);
  }

  Future<void> getDataById(int id) async {
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);
    _profile = await provider.getAllPortfolioProfileById(id, context);

    nameController.text = _profile?.fullName ?? "";
    professionController.text = _profile?.profession ?? "";
    bioController.text = _profile?.bio ?? "";
    mobileController.text = _profile?.mobileNumber ?? "";
    emailController.text = _profile?.email ?? "";
    addressController.text = _profile?.address ?? "";
    linkedInController.text = _profile?.linkedin ?? "";
    githubController.text = _profile?.github ?? "";
    instagramController.text = _profile?.instagram ?? "";
    twitterController.text = _profile?.twitter ?? "";
    projectTitleController.text = _profile?.projectTitle ?? "";
    projectDescriptionController.text = _profile?.projectDescription ?? "";
    projectTechstackController.text = _profile?.projectTechstack ?? "";
    projectUrlController.text = _profile?.projectUrl ?? "";

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> updateDataById(int id) async {
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);

    final updatedProfile = ProfileDataModel(
      id: widget.id,
      fullName: nameController.text,
      profession: professionController.text,
      bio: bioController.text,
      mobileNumber: mobileController.text,
      email: emailController.text,
      address: addressController.text,
      linkedin: linkedInController.text,
      github: githubController.text,
      instagram: instagramController.text,
      twitter: twitterController.text,
      projectTitle: projectTitleController.text,
      projectDescription: projectDescriptionController.text,
      projectTechstack: projectTechstackController.text,
      projectUrl: projectUrlController.text,
    );

    await provider
        .updateProfileProvider(id, updatedProfile.toMap(), context)
        .then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ViewProfile()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // print('Fetching data for ID: ${widget.id}');
    // print('Received profile: $_profile');
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : Form(
              key: _globalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Update Details',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // SizedBox(height: 10,),
                    // Center(
                    //   child: SizedBox(
                    //     height: MediaQuery.of(context).size.height * 0.15,
                    //     width: MediaQuery.of(context).size.width * 0.3,
                    //     child: CameraWidget(),
                    //   ),
                    // ),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: "Enter your name",
                      icon: Icons.account_circle_outlined,
                      labelText: "Name",
                      validator: (value) {
                        if (value == null) {
                          return "enter the name first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: professionController,
                      hintText: "Enter your profession",
                      icon: Icons.work_outline_outlined,
                      labelText: 'Profession',
                      validator: (value) {
                        if (value == null) {
                          return "enter the profession first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: bioController,
                      hintText: "Enter Your Bio",
                      icon: Icons.info_outline_rounded,
                      labelText: "Bio",
                      validator: (value) {
                        if (value == null) {
                          return "enter the bio first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: mobileController,
                      hintText: "Enter your Mobile Number",
                      icon: Icons.smartphone,
                      labelText: "Mobile",
                      validator: (value) {
                        if (value == null) {
                          return "enter the mobile No. first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Enter your Email",
                      icon: Icons.email_outlined,
                      labelText: "Email",
                      validator: (value) {
                        if (value == null) {
                          return "enter the email first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: addressController,
                      hintText: "Enter your address",
                      icon: Icons.location_on,
                      labelText: "Address",
                      validator: (value) {
                        if (value == null) {
                          return "enter the address first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: linkedInController,
                      hintText: "enter linkedIn url",
                      icon: FontAwesomeIcons.linkedin,
                      labelText: "LinkedIn",
                      validator: (value) {
                        if (value == null) {
                          return "enter the linkedIn Url first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: githubController,
                      hintText: "enter github url",
                      icon: FontAwesomeIcons.github,
                      labelText: "Github",
                      validator: (value) {
                        if (value == null) {
                          return "enter the github url first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: instagramController,
                      hintText: "enter instagram url",
                      icon: FontAwesomeIcons.instagram,
                      labelText: "Instagram",
                      validator: (value) {
                        if (value == null) {
                          return "enter the instagram url first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: twitterController,
                      hintText: "enter twitter url",
                      icon: FontAwesomeIcons.twitter,
                      labelText: "Twitter",
                      validator: (value) {
                        if (value == null) {
                          return "enter the twitter url first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: projectTitleController,
                      hintText: "enter project title",
                      icon: Icons.task_outlined,
                      labelText: "Project Title",
                      validator: (value) {
                        if (value == null) {
                          return "enter the project title first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: projectDescriptionController,
                      hintText: "enter project description",
                      icon: Icons.description_outlined,
                      labelText: "Project Description",
                      validator: (value) {
                        if (value == null) {
                          return "enter the project description first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: projectTechstackController,
                      hintText: "enter project Techstack",
                      icon: Icons.code,
                      labelText: "Project Techstack",
                      validator: (value) {
                        if (value == null) {
                          return "enter the project techstack first";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: projectUrlController,
                      hintText: "enter project URL",
                      icon: FontAwesomeIcons.laptopCode,
                      labelText: "Project URL",
                      validator: (value) {
                        if (value == null) {
                          return "enter the project URL first";
                        }
                        return null;
                      },
                    ),

                    ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          updateDataById(widget.id ?? 0);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      child: Text('Update'),
                    ),

                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }
}
