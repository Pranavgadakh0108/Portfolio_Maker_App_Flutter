import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_creator/ui/page9.dart';
import 'package:portfolio_creator/widget/custom_date_field.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';

class Awards extends StatefulWidget {
  const Awards({super.key});

  @override
  State<Awards> createState() => _AwardsState();
}

class _AwardsState extends State<Awards> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  var awardNameController = TextEditingController();
  var awardOrgController = TextEditingController();
  var awardIssueDateController = TextEditingController();
  var awardDescController = TextEditingController();

  String? selectedAwardIssueDate;
  String? _haveAward;

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
                        '8. Awards & Achievements',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      // padding: const EdgeInsets.all(16.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _haveAward,
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
                        hint: Text("Do you have any Award?"),
                        items: [
                          DropdownMenuItem(value: 'Yes', child: Text('Yes')),
                          DropdownMenuItem(value: 'No', child: Text('No')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _haveAward = value;
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
                    if (_haveAward == 'Yes')
                      Column(
                        children: [
                          CustomTextFormField(
                            controller: awardNameController,
                            hintText: "Enter Award Name",
                            icon: FontAwesomeIcons.trophy,
                            keyboardType: TextInputType.text,
                            labelText: "Award Name",
                            onChanged: (value) {
                              setState(() {
                                awardNameController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Award Name first...";
                              }
                              return null;
                            },
                          ),
                          //SizedBox(height: 10),
                          CustomTextFormField(
                            controller: awardOrgController,
                            hintText: "Enter Award Issuing Organization",
                            icon: Icons.business,
                            keyboardType: TextInputType.text,
                            labelText: "Organization Name",
                            onChanged: (value) {
                              setState(() {
                                awardOrgController.text = value;
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
                            controller: awardIssueDateController,
                            hintText: "dd-MM-yyyy",
                            icon1: Icons.calendar_today_outlined,
                            icon2: Icons.calendar_month,
                            labelText: "Award Issue Date",
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1947),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  selectedAwardIssueDate = DateFormat(
                                    "dd-MM-yyyy",
                                  ).format(pickedDate);
                                  awardIssueDateController.text =
                                      selectedAwardIssueDate ?? "";
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
                            controller: awardDescController,
                            maxLines: 3,
                            hintText: "Enter Your Award Description",
                            icon: Icons.description_outlined,
                            keyboardType: TextInputType.text,
                            labelText: "Award Description",
                            onChanged: (value) {
                              setState(() {
                                awardDescController.text = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter the Award Description first...";
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
                              builder: (context) => HobbiesPage(),
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
                            horizontal:MediaQuery.of(context).size.width * 0.31,
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
