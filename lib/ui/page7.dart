import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_creator/ui/page8.dart';
import 'package:portfolio_creator/widget/custom_date_field.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';

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
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text(
                        "Do you have any Certificate?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Yes',
                            groupValue: _haveCertificate,
                            onChanged: (value) {
                              setState(() {
                                _haveCertificate = value;
                              });
                            },
                          ),
                          Text('Yes'),
                          SizedBox(width: 20),
                          Radio<String>(
                            value: 'No',
                            groupValue: _haveCertificate,
                            onChanged: (value) {
                              setState(() {
                                _haveCertificate = value;
                              });
                            },
                          ),
                          Text('No'),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
                          SizedBox(height: 10),
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
                          SizedBox(height: 10),
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
                          SizedBox(height: 10),
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
                          SizedBox(height: 10),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Awards(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade500,
                          foregroundColor: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
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
