import 'package:flutter/material.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/models/profile_data_model.dart';
import 'package:portfolio_creator/provider/profile_data_provider.dart';
import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:portfolio_creator/ui/profile_page.dart';
import 'package:portfolio_creator/widget/custom_dropdown.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String? selectedAvailabilty;
  String? selectedContactMethod;
  var coverLetterController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final setProfileDataProvider = Provider.of<SetProfileDataProvider>(
      context,
      listen: false,
    );

    final profileDataProvider = Provider.of<ProfileDataProvider>(
      context,
      listen: false,
    );
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
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '10. Contact/Hire Me',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomDropDown(
                  labelText: "Availability Status",
                  hintText: "Select Your Availability",
                  items: availabilityStatuses.map((status) {
                    return DropdownMenuItem(value: status, child: Text(status));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAvailabilty = value;
                    });
                  },
                  icon: Icons.check_box_outlined,
                ),

                CustomDropDown(
                  labelText: "Preffered Contact Method",
                  hintText: "Select Your Contact Method",
                  items: preferredContactMethod.map((method) {
                    return DropdownMenuItem(value: method, child: Text(method));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedContactMethod = value;
                    });
                  },
                  icon: Icons.person_add_alt_outlined,
                ),
                //SizedBox(height: 4),
                CustomTextFormField(
                  controller: coverLetterController,
                  maxLines: 5,
                  hintText: "Enter Your Custom Message",
                  icon: Icons.message_outlined,
                  keyboardType: TextInputType.text,
                  labelText: "Cover Letter",
                  onChanged: (value) {
                    setState(() {
                      coverLetterController.text = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Custom Message first...";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setProfileDataProvider.setAvailability(
                        selectedAvailabilty,
                      );
                      setProfileDataProvider.setContactMethod(
                        selectedContactMethod,
                      );
                      setProfileDataProvider.setCoverLetter(
                        coverLetterController.text,
                      );

                      final profile = ProfileDataModel(
                        //profilePhoto: setProfileDataProvider.profilePhoto,
                        fullName: setProfileDataProvider.fullName,
                        profession: setProfileDataProvider.profession,
                        bio: setProfileDataProvider.bio,
                        mobileNumber: setProfileDataProvider.mobileNumber,
                        address: setProfileDataProvider.address,
                        linkedin: setProfileDataProvider.linkedin,
                        github: setProfileDataProvider.github,
                        instagram: setProfileDataProvider.instagram,
                        twitter: setProfileDataProvider.twitter,
                        skills: setProfileDataProvider.skills,
                        ratings: setProfileDataProvider.ratings,
                        degree: setProfileDataProvider.degree,
                        college: setProfileDataProvider.college,
                        startYear: setProfileDataProvider.startYear,
                        endYear: setProfileDataProvider.endYear,
                        experience: setProfileDataProvider.experience,
                        achievement: setProfileDataProvider.achievement,
                        hasExperience: setProfileDataProvider.hasExperience,
                        jobTitle: setProfileDataProvider.jobTitle,
                        companyName: setProfileDataProvider.companyName,
                        startDate: setProfileDataProvider.startDate,
                        endDate: setProfileDataProvider.endDate,
                        companyLocation: setProfileDataProvider.companyLocation,
                        responsibilities:
                            setProfileDataProvider.responsibilities,
                        projectTitle: setProfileDataProvider.projectTitle,
                        projectDescription:
                            setProfileDataProvider.projectDescription,
                        projectTechstack:
                            setProfileDataProvider.projectTechstack,
                        projectUrl: setProfileDataProvider.projectUrl,
                        projectImg: setProfileDataProvider.projectImg,
                        haveCertificate: setProfileDataProvider.haveCertificate,
                        certificateName: setProfileDataProvider.certificateName,
                        organizationName:
                            setProfileDataProvider.organizationName,
                        issueDate: setProfileDataProvider.issueDate,
                        certificateUrl: setProfileDataProvider.certificateUrl,
                        certificateDescription:
                            setProfileDataProvider.certificateDescription,
                        haveAward: setProfileDataProvider.haveAward,
                        awardName: setProfileDataProvider.awardName,
                        awardOrgName: setProfileDataProvider.awardOrgName,
                        awardIsuDate: setProfileDataProvider.awardIsuDate,
                        awardDesc: setProfileDataProvider.awardDesc,
                        hobbies: setProfileDataProvider.hobbies,
                        availability: setProfileDataProvider.availability,
                        contactMethod: setProfileDataProvider.contactMethod,
                        coverLetter: setProfileDataProvider.coverLetter,
                      );

                      profileDataProvider
                          .insertPortfolioProfile(context, profile)
                          .then((_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          });
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
                        horizontal: MediaQuery.of(context).size.width * 0.31,
                        vertical: 10,
                      ),
                      child: Text("Submit", style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
