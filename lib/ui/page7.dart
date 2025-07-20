import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:portfolio_creator/ui/page8.dart';
import 'package:portfolio_creator/widget/custom_date_field.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:provider/provider.dart';

class Certifications extends StatefulWidget {
  const Certifications({super.key});

  @override
  State<Certifications> createState() => _CetificationsState();
}

class _CetificationsState extends State<Certifications> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  var certificateNameController = TextEditingController();
  var certificateOrgController = TextEditingController();
  var issueDateController = TextEditingController();
  var certificateUrlController = TextEditingController();
  var certificateDescController = TextEditingController();

  String? selectedIssueDate;
  String? _haveCertificate;

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
                        '7. Certifications',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      //padding: const EdgeInsets.all(16.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _haveCertificate,
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black38),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.purple,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12),
                          ), // Optional border
                          //contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.02,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                        hint: Text("Do you have any Certificate?"),
                        items: [
                          DropdownMenuItem(value: 'Yes', child: Text('Yes')),
                          DropdownMenuItem(value: 'No', child: Text('No')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _haveCertificate = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                    ),
                    //SizedBox(height: 10),
                    if (_haveCertificate == 'Yes')
                      Column(
                        children: [
                          CustomTextFormField(
                            controller: certificateNameController,
                            hintText: "Enter Certificate Name",
                            icon: FontAwesomeIcons.medal,
                            keyboardType: TextInputType.text,
                            labelText: "Certificate Name",
                            onChanged: (value) {
                              setState(() {
                                certificateNameController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Certificate Name first...";
                              }
                              return null;
                            },
                          ),
                          //SizedBox(height: 10),
                          CustomTextFormField(
                            controller: certificateOrgController,
                            hintText: "Enter certificate Issuing Organization",
                            icon: Icons.business,
                            keyboardType: TextInputType.text,
                            labelText: "Organization Name",
                            onChanged: (value) {
                              setState(() {
                                certificateOrgController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Organization Name first...";
                              }
                              return null;
                            },
                          ),
                          //SizedBox(height: 10),
                          CustomDateField(
                            controller: issueDateController,
                            hintText: "dd-MM-yyyy",
                            icon1: Icons.calendar_today_outlined,
                            icon2: Icons.calendar_month,
                            labelText: "Certificate Issue Date",
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1947),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  selectedIssueDate = DateFormat(
                                    "dd-MM-yyyy",
                                  ).format(pickedDate);
                                  issueDateController.text =
                                      selectedIssueDate ?? "";
                                });
                              }
                            },
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Issue Date First";
                              }
                              return null;
                            },
                          ),
                          //SizedBox(height: 10),
                          CustomTextFormField(
                            controller: certificateUrlController,
                            hintText: "Enter Your Certificate URL",
                            icon: FontAwesomeIcons.link,
                            keyboardType: TextInputType.text,
                            labelText: "Certificate URL",
                            onChanged: (value) {
                              setState(() {
                                certificateUrlController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Certificate URL First..";
                              }
                              return null;
                            },
                          ),
                          //SizedBox(height: 10),
                          CustomTextFormField(
                            controller: certificateDescController,
                            maxLines: 3,
                            hintText: "Enter Your Certificate Description",
                            icon: Icons.description_outlined,
                            keyboardType: TextInputType.text,
                            labelText: "Certificate Description",
                            onChanged: (value) {
                              setState(() {
                                certificateDescController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Certificate Description first...";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setProfileDataProvider.setHaveCertificate(
                            _haveCertificate,
                          );
                          setProfileDataProvider.setCertificateName(
                            certificateNameController.text,
                          );
                          setProfileDataProvider.setOrganizationName(
                            certificateOrgController.text,
                          );
                          setProfileDataProvider.setIssueDate(
                            selectedIssueDate,
                          );
                          setProfileDataProvider.setCertificateUrl(
                            certificateUrlController.text,
                          );
                          setProfileDataProvider.setCertificateDescription(
                            certificateDescController.text,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Awards()),
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
