import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:portfolio_creator/ui/page3.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:provider/provider.dart';

class SocialLinks extends StatefulWidget {
  const SocialLinks({super.key});

  @override
  State<SocialLinks> createState() => _SocialLinksState();
}

class _SocialLinksState extends State<SocialLinks> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  var linkedInController = TextEditingController();
  var githubController = TextEditingController();

  var instagramController = TextEditingController();
  var twitterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final setProfileDataProvider = Provider.of<SetProfileDataProvider>(
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
                        '2. Social Links',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    CustomTextFormField(
                      controller: linkedInController,
                      hintText: "Enter Your LinkedIn Profile Link URL",
                      icon: FontAwesomeIcons.linkedin,
                      keyboardType: TextInputType.text,
                      labelText: "LinkedIn URL",
                      onChanged: (value) {
                        setState(() {
                          linkedInController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter LinkedIn URL First..";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: githubController,
                      hintText: "Enter Your GitHub Profile Link URL",
                      icon: FontAwesomeIcons.github,
                      keyboardType: TextInputType.text,
                      labelText: "GitHub URL",
                      onChanged: (value) {
                        setState(() {
                          githubController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter GitHub URL First..";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: instagramController,
                      hintText: "Enter Your Instagram Link URL",
                      icon: FontAwesomeIcons.instagram,
                      keyboardType: TextInputType.text,
                      labelText: "Instagram URL",
                      onChanged: (value) {
                        setState(() {
                          instagramController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Instagram URL First..";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: twitterController,
                      hintText: "Enter Your Twitter Link URL",
                      icon: FontAwesomeIcons.twitter,
                      keyboardType: TextInputType.text,
                      labelText: "Twitter URL",
                      onChanged: (value) {
                        setState(() {
                          twitterController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Twitter URL First..";
                        }
                        return null;
                      },
                    ),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setProfileDataProvider.setLinkedIn(
                            linkedInController.text,
                          );
                          setProfileDataProvider.setGithub(
                            githubController.text,
                          );
                          setProfileDataProvider.setInstagram(
                            instagramController.text,
                          );
                          setProfileDataProvider.setTwitter(
                            twitterController.text,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SkillsPage(),
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
