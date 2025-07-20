import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:portfolio_creator/ui/page4.dart';
import 'package:provider/provider.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  late List<bool?> selectedValues;
  late List<String> selectedSkills;
  late String skillsJson;
  late List<String?> selectedRatings;
  late String ratingsJson;

  @override
  void initState() {
    super.initState();
    selectedValues = List<bool?>.filled(skills.length, false);
    selectedSkills = [];
    selectedRatings = List<String?>.filled(skills.length, null);
    _updateJsonData();
  }

  void _updateJsonData() {
    setState(() {
      // Create a map of selected skills with their ratings
      final Map<String, String?> skillsWithRatings = {};
      for (int i = 0; i < skills.length; i++) {
        if (selectedValues[i] == true) {
          skillsWithRatings[skills[i]] = selectedRatings[i];
        }
      }
      skillsJson = jsonEncode(skillsWithRatings);
      ratingsJson = jsonEncode(
        selectedRatings.where((r) => r != null).toList(),
      );
    });
  }

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
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.purple,
        elevation: 5,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: Text(
                '3. Select Skills',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  final skill = skills[index];
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text(skill),
                          value: selectedValues[index],
                          activeColor: Colors.purple,
                          checkColor: Colors.white,
                          controlAffinity: ListTileControlAffinity.leading,
                          side: BorderSide(color: Colors.purple),
                          onChanged: (value) {
                            setState(() {
                              selectedValues[index] = value;
                              if (value == true) {
                                selectedSkills.add(skill);
                              } else {
                                selectedSkills.remove(skill);
                                selectedRatings[index] = null;
                              }
                              _updateJsonData();
                            });
                          },
                        ),
                        if (selectedValues[index] ?? false)
                          Column(
                            children: ratings.map((rating) {
                              return RadioListTile<String>(
                                title: Text(rating),
                                value: rating,
                                groupValue: selectedRatings[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedRatings[index] = value;
                                    _updateJsonData();
                                  });
                                },
                                activeColor: Colors.purple,
                                toggleable: false,
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save data to provider before navigation
                  setProfileDataProvider.setSkills(skillsJson);
                  setProfileDataProvider.setRatings(ratingsJson);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EducationDetails()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade500,
                  foregroundColor: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.31,
                    vertical: 10,
                  ),
                  child: Text("Next Page", style: TextStyle(fontSize: 13)),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
