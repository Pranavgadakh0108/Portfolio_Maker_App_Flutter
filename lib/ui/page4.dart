import 'package:flutter/material.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/ui/page5.dart';
import 'package:portfolio_creator/widget/custom_dropdown.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';

class EducationDetails extends StatefulWidget {
  const EducationDetails({super.key});

  @override
  State<EducationDetails> createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  String? selectedDegree;
  String? selectedCollege;
  String? startYear;
  String? endYear;
  var expController = TextEditingController();
  var achievementController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
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
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    '4. Education Details',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomDropDown(
                  labelText: "Degree",
                  hintText: "Select Your Degree",
                  items: degrees.map((degree) {
                    return DropdownMenuItem(value: degree, child: Text(degree));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDegree = value;
                    });
                  },
                  icon: Icons.school_outlined,
                ),

                CustomDropDown(
                  labelText: "College",
                  hintText: "Select Your College",
                  items: colleges.map((college) {
                    return DropdownMenuItem(
                      value: college,
                      child: Text(college),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCollege = value;
                    });
                  },
                  icon: Icons.account_balance_outlined,
                ),

                CustomDropDown(
                  labelText: "Start Year",
                  hintText: "Select Your Start Year",
                  items: years.map((year) {
                    return DropdownMenuItem(value: year, child: Text(year));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      startYear = value;
                    });
                  },
                  icon: Icons.calendar_month_outlined,
                ),

                CustomDropDown(
                  labelText: "End Year",
                  hintText: "Select Your End Year",
                  items: years.map((year) {
                    return DropdownMenuItem(value: year, child: Text(year));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      endYear = value;
                    });
                  },
                  icon: Icons.calendar_month_outlined,
                ),

                //SizedBox(height: 4),
                CustomTextFormField(
                  controller: expController,
                  maxLines: 3,
                  hintText: "Write your Experience",
                  icon: Icons.work_history_outlined,
                  keyboardType: TextInputType.text,
                  labelText: "Experience",
                  onChanged: (value) {
                    setState(() {
                      expController.text = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Experience first...";
                    }
                    return null;
                  },
                ),
                //SizedBox(height: 10),
                CustomTextFormField(
                  controller: achievementController,
                  maxLines: 3,
                  hintText: "Write your Achievments",
                  icon: Icons.emoji_events_outlined,
                  keyboardType: TextInputType.text,
                  labelText: "Achievments",
                  onChanged: (value) {
                    setState(() {
                      achievementController.text = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Achievments first...";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkExperience(),
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
                        horizontal: MediaQuery.of(context).size.width * 0.31,
                        vertical: 10,
                      ),
                      child: Text("Next Page", style: TextStyle(fontSize: 13)),
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
