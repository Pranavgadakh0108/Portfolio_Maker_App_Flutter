import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_creator/models/profile_data_model.dart';
import 'package:portfolio_creator/provider/profile_data_provider.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/build_contact_button.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/build_divider.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/build_info_card.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/build_project_card.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/build_section_title.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/build_social_button.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/get_hobby_icon.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/make_phone_call.dart';
import 'package:portfolio_creator/widget/portfolio_widgets/send_email.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Portfolio extends StatefulWidget {
  final int? id;

  const Portfolio({super.key, required this.id});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
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
    setState(() {
      _isLoading = false;
    });
  }

  Map<String, String> _parseSkills(String? skillsJson) {
    try {
      if (skillsJson == null || skillsJson.isEmpty) {
        return {};
      }
      final Map<String, dynamic> skillsMap = jsonDecode(skillsJson);
      final Map<String, String> filteredSkills = {};
      skillsMap.forEach((key, value) {
        if (value != null) {
          filteredSkills[key] = value.toString();
        }
      });
      return filteredSkills;
    } catch (e) {
      debugPrint("Error parsing skills: $e");
      return {};
    }
  }

  List<dynamic> _parseHobbies(String? hobbiesJson) {
    try {
      if (hobbiesJson == null || hobbiesJson.isEmpty) {
        return [];
      }
      return jsonDecode(hobbiesJson);
    } catch (e) {
      debugPrint("Error parsing hobbies: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final skills = _parseSkills(_profile?.skills);
    final hobbies = _parseHobbies(_profile?.hobbies);

    final Uri projUrl = Uri.parse(_profile?.projectUrl ?? "");
    final Uri certiUrl = Uri.parse(_profile?.certificateUrl ?? "");
    final Uri linkedUrl = Uri.parse(_profile?.linkedin ?? "");
    final Uri gitUrl = Uri.parse(_profile?.github ?? "");
    final Uri instaUrl = Uri.parse(_profile?.instagram ?? "");
    final Uri twitterUrl = Uri.parse(_profile?.twitter ?? "");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Professional Portfolio',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.purple,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.purple))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Center(
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(25),
                  //     child: _profile?.profilePhoto == null
                  //         ? const Icon(
                  //             Icons.person,
                  //             size: 40,
                  //             color: Colors.grey,
                  //           )
                  //         : Image.file(
                  //             File(_profile?.profilePhoto ?? ""),
                  //             fit: BoxFit.cover,
                  //             height: 130,
                  //             width: 100,
                  //           ),
                  //   ),
                  // ),
                  Center(
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.shade100,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(-4, 0)
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: _profile?.profilePhoto == null
                              ? Container(
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey[600],
                                  ),
                                )
                              : Image.file(
                                  File(_profile?.profilePhoto ?? ""),
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _profile?.fullName ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    _profile?.profession ?? "",
                    style: const TextStyle(fontSize: 14, color: Colors.purple),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      if (_profile?.email != null &&
                          _profile!.email!.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.email,
                              size: 16,
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 5),
                            Text(_profile!.email!),
                          ],
                        ),
                      if (_profile?.mobileNumber != null &&
                          _profile!.mobileNumber!.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 16,
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 5),
                            Text(_profile!.mobileNumber!),
                          ],
                        ),
                      if (_profile?.address != null &&
                          _profile!.address!.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 5),
                            Text(_profile!.address!),
                          ],
                        ),
                    ],
                  ),

                  BuildDivider(),

                  // About Section
                  if (_profile?.bio != null && _profile!.bio!.isNotEmpty) ...[
                    BuildSectionTitle(title: "About Me"),
                    Text(
                      _profile!.bio!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, height: 1.5),
                    ),
                    BuildDivider(),
                  ],

                  // Education Section
                  if (_profile?.degree != null ||
                      _profile?.college != null) ...[
                    BuildSectionTitle(title: "Education"),
                    BuildInfoCard(
                      title: _profile?.degree ?? "",
                      subtitle:
                          "${_profile?.college} (${_profile?.startYear} - ${_profile?.endYear})",
                      description: "Achievement: ${_profile?.achievement}",
                    ),
                    const SizedBox(height: 2),
                    if (_profile?.experience != null &&
                        _profile!.experience!.isNotEmpty)
                      Text(
                        "Experience: ${_profile!.experience}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    BuildDivider(),
                  ],

                  // Skills Section
                  if (skills.isNotEmpty) ...[
                    BuildSectionTitle(title: "Skills"),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: skills.entries.map((entry) {
                        return Chip(
                          label: Text(entry.key),
                          backgroundColor: Colors.purple[50],
                          labelStyle: const TextStyle(
                            color: Colors.purple,
                            fontSize: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }).toList(),
                    ),
                    BuildDivider(),
                  ],

                  // Work Experience
                  if (_profile?.hasExperience == 'Yes')
                    if (_profile?.jobTitle != null ||
                        _profile?.companyName != null) ...[
                      BuildSectionTitle(title: "Work Experience"),
                      BuildInfoCard(
                        title: _profile?.jobTitle ?? "",
                        subtitle:
                            "${_profile?.companyName} (${_profile?.companyLocation})",
                        period: "${_profile?.startDate} - ${_profile?.endDate}",
                        description:
                            "Responsibilities: ${_profile?.responsibilities}",
                      ),
                      BuildDivider(),
                    ],

                  // Projects
                  if (_profile?.projectTitle != null ||
                      _profile?.projectDescription != null) ...[
                    BuildSectionTitle(title: "Projects"),
                    BuildProjectCard(
                      title: _profile?.projectTitle ?? "",
                      techStack: _profile?.projectTechstack ?? "",
                      description: _profile?.projectDescription ?? "",
                      image: _profile?.projectImg,
                      url: projUrl,
                    ),
                    BuildDivider(),
                  ],

                  // Certificates
                  if (_profile?.haveCertificate == "Yes")
                    if (_profile?.certificateName != null ||
                        _profile?.organizationName != null) ...[
                      BuildSectionTitle(title: "Certifications"),
                      BuildInfoCard(
                        title: _profile?.certificateName ?? "",
                        subtitle: _profile?.organizationName ?? "",
                        period: "Issued: ${_profile?.issueDate}",
                        description: _profile?.certificateDescription ?? "",
                        url: certiUrl,
                      ),
                      BuildDivider(),
                    ],

                  // Awards
                  if (_profile?.haveAward == "Yes")
                    if (_profile?.awardName != null ||
                        _profile?.awardOrgName != null) ...[
                      BuildSectionTitle(title: "Award"),
                      BuildInfoCard(
                        title: _profile?.awardName ?? "",
                        subtitle: _profile?.awardOrgName ?? "",
                        period: "Issued: ${_profile?.awardIsuDate}",
                        description: _profile?.awardDesc ?? "",
                      ),
                      BuildDivider(),
                    ],

                  // Hobbies
                  if (hobbies.isNotEmpty) ...[
                    BuildSectionTitle(title: "Hobbies & Interests"),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: hobbies.map((hobby) {
                        return Chip(
                          avatar: Icon(
                            getHobbyIcon(hobby),
                            size: 14,
                            color: Colors.purple,
                          ),
                          label: Text(
                            hobby.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: Colors.purple[50],
                        );
                      }).toList(),
                    ),
                    BuildDivider(),
                  ],

                  // Contact Section
                  BuildSectionTitle(title: "Contact Me"),
                  if (_profile?.availability != null &&
                      _profile!.availability!.isNotEmpty)
                    Text(
                      "Availability: ${_profile!.availability}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  if (_profile?.contactMethod != null &&
                      _profile!.contactMethod!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      "Preferred contact method: ${_profile!.contactMethod}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 4),
                  const Text(
                    "Connect with me:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_profile?.linkedin != null &&
                          _profile!.linkedin!.isNotEmpty)
                        BuildSocialButton(
                          icon: FontAwesomeIcons.linkedin,
                          onPressed: () async {
                            try {
                              await launchUrl(
                                linkedUrl,
                                mode: LaunchMode.externalApplication,
                              );
                            } catch (e) {
                              debugPrint("Error: $e");
                            }
                          },
                        ),
                      if (_profile?.github != null &&
                          _profile!.github!.isNotEmpty)
                        BuildSocialButton(
                          icon: FontAwesomeIcons.github,
                          onPressed: () async {
                            try {
                              await launchUrl(
                                gitUrl,
                                mode: LaunchMode.externalApplication,
                              );
                            } catch (e) {
                              debugPrint("Error: $e");
                            }
                          },
                        ),
                      if (_profile?.instagram != null &&
                          _profile!.instagram!.isNotEmpty)
                        BuildSocialButton(
                          icon: FontAwesomeIcons.instagram,
                          onPressed: () async {
                            try {
                              await launchUrl(
                                instaUrl,
                                mode: LaunchMode.externalApplication,
                              );
                            } catch (e) {
                              debugPrint("Error: $e");
                            }
                          },
                        ),
                      if (_profile?.twitter != null &&
                          _profile!.twitter!.isNotEmpty)
                        BuildSocialButton(
                          icon: FontAwesomeIcons.twitter,
                          onPressed: () async {
                            try {
                              await launchUrl(
                                twitterUrl,
                                mode: LaunchMode.externalApplication,
                              );
                            } catch (e) {
                              debugPrint("Error: $e");
                            }
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_profile?.mobileNumber != null &&
                          _profile!.mobileNumber!.isNotEmpty)
                        BuildContactButton(
                          icon: Icons.phone,
                          onPressed: () =>
                              makePhoneCall(_profile?.mobileNumber),
                        ),
                      if (_profile?.email != null &&
                          _profile!.email!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        BuildContactButton(
                          icon: Icons.email,
                          onPressed: () => sendEmail(context, _profile?.email),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_profile?.coverLetter != null &&
                      _profile!.coverLetter!.isNotEmpty)
                    Text(
                      _profile!.coverLetter!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}
