import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_creator/ui/page6.dart';
import 'package:portfolio_creator/widget/custom_date_field.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  var jobTitleController = TextEditingController();
  var companyNameController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var locationController = TextEditingController();
  var responsibilitiesController = TextEditingController();
  String? selectedStartDate;
  String? selectedEndDate;

  String? _hasExperience;

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
                        '5. Work Experience',
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
                        "Do you have work experience?",
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
                            groupValue: _hasExperience,
                            onChanged: (value) {
                              setState(() {
                                _hasExperience = value;
                              });
                            },
                          ),
                          Text('Yes'),
                          SizedBox(width: 20),
                          Radio<String>(
                            value: 'No',
                            groupValue: _hasExperience,
                            onChanged: (value) {
                              setState(() {
                                _hasExperience = value;
                              });
                            },
                          ),
                          Text('No'),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    if (_hasExperience == 'Yes')
                      Column(
                        children: [
                          CustomTextFormField(
                            controller: jobTitleController,
                            hintText: "Enter Your Job Title",
                            icon: Icons.work_outline_outlined,
                            keyboardType: TextInputType.text,
                            labelText: "Job Title",
                            onChanged: (value) {
                              setState(() {
                                jobTitleController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Job Title first...";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            controller: companyNameController,
                            hintText: "Enter Your Company Name",
                            icon: Icons.account_balance_outlined,
                            keyboardType: TextInputType.text,
                            labelText: "Company Name",
                            onChanged: (value) {
                              setState(() {
                                companyNameController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Company Name first...";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomDateField(
                            controller: startDateController,
                            hintText: "dd-MM-yyyy",
                            icon1: Icons.calendar_today_outlined,
                            icon2: Icons.calendar_month,
                            labelText: "Start Date",
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1947),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  selectedStartDate = DateFormat(
                                    "dd-MM-yyyy",
                                  ).format(pickedDate);
                                  startDateController.text =
                                      selectedStartDate ?? "";
                                });
                              }
                            },
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Start Date First";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomDateField(
                            controller: endDateController,
                            hintText: "dd-MM-yyyy",
                            icon1: Icons.calendar_today_outlined,
                            icon2: Icons.calendar_month,
                            labelText: "End Date",
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1947),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  selectedEndDate = DateFormat(
                                    "dd-MM-yyyy",
                                  ).format(pickedDate);
                                  endDateController.text =
                                      selectedEndDate ?? "";
                                });
                              }
                            },
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the End Date First";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            controller: locationController,
                            hintText: "Enter Your Company Location",
                            icon: Icons.location_on_outlined,
                            keyboardType: TextInputType.text,
                            labelText: "Company Location",
                            onChanged: (value) {
                              setState(() {
                                locationController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Company Location first...";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            controller: responsibilitiesController,
                            hintText: "Enter Your Responsibilities",
                            maxLines: 2,
                            icon: Icons.business_center_outlined,
                            keyboardType: TextInputType.text,
                            labelText: "Responsibilities",
                            onChanged: (value) {
                              setState(() {
                                responsibilitiesController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Responsibilities first...";
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
                              builder: (context) => Projects(),
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
