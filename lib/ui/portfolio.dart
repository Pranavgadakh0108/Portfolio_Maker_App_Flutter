import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
// import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    final skills = _parseSkills(_profile?.skills);
    final hobbies = _parseHobbies(_profile?.hobbies);

    // Define colors and styles
    final primaryColor = PdfColors.blue800;
    final secondaryColor = PdfColors.grey600;
    final accentColor = PdfColors.blue100;
    final headerStyle = pw.TextStyle(
      fontSize: 16,
      fontWeight: pw.FontWeight.bold,
      color: primaryColor,
    );
    final sectionHeaderStyle = pw.TextStyle(
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
      color: primaryColor,
    );
    final subtitleStyle = pw.TextStyle(fontSize: 10, color: secondaryColor);

    // Add profile image if available
    pw.Widget? profileImage;
    if (_profile?.profilePhoto != null && _profile!.profilePhoto!.isNotEmpty) {
      try {
        final imageFile = File(_profile!.profilePhoto!);
        if (await imageFile.exists()) {
          final imageBytes = await imageFile.readAsBytes();
          profileImage = pw.Image(
            pw.MemoryImage(imageBytes),
            width: 80,
            height: 80,
            fit: pw.BoxFit.cover,
          );
        }
      } catch (e) {
        debugPrint("Error loading profile image: $e");
      }
    }

    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.all(30),
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData(
          defaultTextStyle: pw.TextStyle(fontSize: 12, color: PdfColors.black),
        ),
        build: (pw.Context context) => [
          // Header with two columns
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Left column with profile image
              pw.Container(
                width: 100,
                child: pw.Column(
                  children: [
                    if (profileImage != null)
                      pw.Container(
                        width: 80,
                        height: 80,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          border: pw.Border.all(color: primaryColor, width: 2),
                        ),
                        child: pw.ClipOval(child: profileImage),
                      )
                    else
                      pw.Container(
                        width: 80,
                        height: 80,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          color: accentColor,
                          border: pw.Border.all(color: primaryColor, width: 2),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            _profile?.fullName?.substring(0, 1) ?? 'P',
                            style: pw.TextStyle(
                              fontSize: 30,
                              color: primaryColor,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    pw.SizedBox(height: 10),
                    // Contact info in the left column
                    if (_profile?.email != null && _profile!.email!.isNotEmpty)
                      pw.Text(
                        _profile!.email!,
                        style: subtitleStyle,

                        textAlign: pw.TextAlign.center,
                      ),
                    if (_profile?.mobileNumber != null &&
                        _profile!.mobileNumber!.isNotEmpty)
                      pw.Text(
                        _profile!.mobileNumber!,
                        style: subtitleStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                    if (_profile?.address != null &&
                        _profile!.address!.isNotEmpty)
                      pw.Text(
                        _profile!.address!,
                        style: subtitleStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                  ],
                ),
              ),
              pw.SizedBox(width: 20),
              // Right column with name and profession
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(_profile?.fullName ?? "", style: headerStyle),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      _profile?.profession ?? "",
                      style: pw.TextStyle(
                        fontSize: 14,
                        color: secondaryColor,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    if (_profile?.bio != null && _profile!.bio!.isNotEmpty)
                      pw.Text(
                        _profile!.bio!,
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 11,
                          color: secondaryColor,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          pw.Divider(thickness: 1, color: primaryColor),
          pw.SizedBox(height: 10),

          // Main content with two columns
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Left column (skills, hobbies, contact)
              pw.Container(
                width: 150,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Skills Section
                    if (skills.isNotEmpty) ...[
                      pw.Text('SKILLS', style: sectionHeaderStyle),
                      pw.SizedBox(height: 5),
                      pw.Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: skills.entries.map((entry) {
                          return pw.Container(
                            padding: pw.EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: pw.BoxDecoration(
                              color: accentColor,
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Text(
                              entry.key,
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          );
                        }).toList(),
                      ),
                      pw.SizedBox(height: 15),
                    ],

                    // Hobbies Section
                    if (hobbies.isNotEmpty) ...[
                      pw.Text('HOBBIES', style: sectionHeaderStyle),
                      pw.SizedBox(height: 5),
                      pw.Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: hobbies.map((hobby) {
                          return pw.Container(
                            padding: pw.EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: pw.BoxDecoration(
                              color: accentColor,
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Text(
                              hobby.toString(),
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          );
                        }).toList(),
                      ),
                      pw.SizedBox(height: 15),
                    ],

                    // Social Links
                    if ((_profile?.linkedin != null &&
                            _profile!.linkedin!.isNotEmpty) ||
                        (_profile?.github != null &&
                            _profile!.github!.isNotEmpty) ||
                        (_profile?.instagram != null &&
                            _profile!.instagram!.isNotEmpty) ||
                        (_profile?.twitter != null &&
                            _profile!.twitter!.isNotEmpty)) ...[
                      pw.Text('CONNECT', style: sectionHeaderStyle),
                      pw.SizedBox(height: 5),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (_profile?.linkedin != null &&
                              _profile!.linkedin!.isNotEmpty)
                            pw.Text(
                              'LinkedIn: ${_profile!.linkedin}',
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          if (_profile?.github != null &&
                              _profile!.github!.isNotEmpty)
                            pw.Text(
                              'GitHub: ${_profile!.github}',
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          if (_profile?.instagram != null &&
                              _profile!.instagram!.isNotEmpty)
                            pw.Text(
                              'Instagram: ${_profile!.instagram}',
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          if (_profile?.twitter != null &&
                              _profile!.twitter!.isNotEmpty)
                            pw.Text(
                              'Twitter: ${_profile!.twitter}',
                              style: pw.TextStyle(fontSize: 10),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              pw.SizedBox(width: 20),
              // Right column (main content)
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Education Section
                    if (_profile?.degree != null ||
                        _profile?.college != null) ...[
                      pw.Text('EDUCATION', style: sectionHeaderStyle),
                      pw.SizedBox(height: 5),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            _profile?.degree ?? "",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            _profile?.college ?? "",
                            style: subtitleStyle,
                          ),
                          pw.Text(
                            "${_profile?.startYear ?? ""} - ${_profile?.endYear ?? ""}",
                            style: subtitleStyle,
                          ),
                          if (_profile?.achievement != null &&
                              _profile!.achievement!.isNotEmpty)
                            pw.Text(
                              "Achievement: ${_profile!.achievement}",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          if (_profile?.experience != null &&
                              _profile!.experience!.isNotEmpty)
                            pw.Text(
                              "Experience: ${_profile!.experience}",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                        ],
                      ),
                      pw.SizedBox(height: 15),
                    ],

                    // Work Experience
                    if (_profile?.hasExperience == 'Yes')
                      if (_profile?.jobTitle != null ||
                          _profile?.companyName != null) ...[
                        pw.Text('WORK EXPERIENCE', style: sectionHeaderStyle),
                        pw.SizedBox(height: 5),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              _profile?.jobTitle ?? "",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            pw.Text(
                              _profile?.companyName ?? "",
                              style: subtitleStyle,
                            ),
                            pw.Text(
                              _profile?.companyLocation ?? "",
                              style: subtitleStyle,
                            ),
                            pw.Text(
                              "${_profile?.startDate ?? ""} - ${_profile?.endDate ?? ""}",
                              style: subtitleStyle,
                            ),
                            if (_profile?.responsibilities != null &&
                                _profile!.responsibilities!.isNotEmpty)
                              pw.Text(
                                "Responsibilities: ${_profile!.responsibilities}",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                          ],
                        ),
                        pw.SizedBox(height: 15),
                      ],

                    // Projects
                    if (_profile?.projectTitle != null ||
                        _profile?.projectDescription != null) ...[
                      pw.Text('PROJECTS', style: sectionHeaderStyle),
                      pw.SizedBox(height: 5),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            _profile?.projectTitle ?? "",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          if (_profile?.projectTechstack != null &&
                              _profile!.projectTechstack!.isNotEmpty)
                            pw.Text(
                              "Tech Stack: ${_profile!.projectTechstack}",
                              style: subtitleStyle,
                            ),
                          if (_profile?.projectDescription != null &&
                              _profile!.projectDescription!.isNotEmpty)
                            pw.Text(
                              _profile!.projectDescription!,
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          if (_profile?.projectUrl != null &&
                              _profile!.projectUrl!.isNotEmpty)
                            pw.Text(
                              "URL: ${_profile!.projectUrl}",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.blue,
                                decoration: pw.TextDecoration.underline,
                              ),
                            ),
                        ],
                      ),
                      pw.SizedBox(height: 15),
                    ],

                    // Certificates
                    if (_profile?.haveCertificate == "Yes")
                      if (_profile?.certificateName != null ||
                          _profile?.organizationName != null) ...[
                        pw.Text('CERTIFICATIONS', style: sectionHeaderStyle),
                        pw.SizedBox(height: 5),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              _profile?.certificateName ?? "",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            pw.Text(
                              _profile?.organizationName ?? "",
                              style: subtitleStyle,
                            ),
                            pw.Text(
                              "Issued: ${_profile?.issueDate ?? ""}",
                              style: subtitleStyle,
                            ),
                            if (_profile?.certificateDescription != null &&
                                _profile!.certificateDescription!.isNotEmpty)
                              pw.Text(
                                _profile!.certificateDescription!,
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            if (_profile?.certificateUrl != null &&
                                _profile!.certificateUrl!.isNotEmpty)
                              pw.Text(
                                "URL: ${_profile!.certificateUrl}",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColors.blue,
                                  decoration: pw.TextDecoration.underline,
                                ),
                              ),
                          ],
                        ),
                        pw.SizedBox(height: 15),
                      ],

                    // Awards
                    if (_profile?.haveAward == "Yes")
                      if (_profile?.awardName != null ||
                          _profile?.awardOrgName != null) ...[
                        pw.Text('AWARDS', style: sectionHeaderStyle),
                        pw.SizedBox(height: 5),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              _profile?.awardName ?? "",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            pw.Text(
                              _profile?.awardOrgName ?? "",
                              style: subtitleStyle,
                            ),
                            pw.Text(
                              "Issued: ${_profile?.awardIsuDate ?? ""}",
                              style: subtitleStyle,
                            ),
                            if (_profile?.awardDesc != null &&
                                _profile!.awardDesc!.isNotEmpty)
                              pw.Text(
                                _profile!.awardDesc!,
                                style: pw.TextStyle(fontSize: 10),
                              ),
                          ],
                        ),
                        pw.SizedBox(height: 15),
                      ],

                    // Cover Letter
                    if (_profile?.coverLetter != null &&
                        _profile!.coverLetter!.isNotEmpty) ...[
                      pw.Text('COVER LETTER', style: sectionHeaderStyle),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        _profile!.coverLetter!,
                        textAlign: pw.TextAlign.justify,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return await pdf.save();
  }

  // Future<void> _savePdf() async {
  //   try {
  //     final bytes = await _generatePdf();
  //     final dir = await getApplicationDocumentsDirectory();
  //     final file = File('${dir.path}/${_profile?.fullName ?? 'portfolio'}.pdf');
  //     await file.writeAsBytes(bytes);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('PDF saved to ${file.path}'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to save PDF: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> _sharePdf() async {
    try {
      final bytes = await _generatePdf();
      await Printing.sharePdf(
        bytes: bytes,
        filename: '${_profile?.fullName ?? 'portfolio'}.pdf',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to share PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
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
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf, color: Colors.white),
            onPressed: _sharePdf,
            tooltip: 'Export as PDF',
          ),
        ],
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
                            offset: Offset(-4, 0),
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
