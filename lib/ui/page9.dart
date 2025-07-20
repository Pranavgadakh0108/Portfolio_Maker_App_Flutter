import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:portfolio_creator/ui/page10.dart';
import 'package:provider/provider.dart';

class HobbiesPage extends StatefulWidget {
  const HobbiesPage({super.key});

  @override
  State<HobbiesPage> createState() => _HobbiesPageState();
}

class _HobbiesPageState extends State<HobbiesPage> {
  late List<bool> selectedValues;
  List<String> selectedHobbies = [];
  late String hobbiesJson;

  final List<IconData> hobbyIcons = [
    FontAwesomeIcons.code,
    FontAwesomeIcons.mobileScreenButton,
    FontAwesomeIcons.globe,
    FontAwesomeIcons.github,
    FontAwesomeIcons.rankingStar,
    FontAwesomeIcons.laptopCode,
    FontAwesomeIcons.handshake,
    FontAwesomeIcons.blog,
    FontAwesomeIcons.newspaper,
    FontAwesomeIcons.video,
    FontAwesomeIcons.youtube,
    FontAwesomeIcons.lightbulb,
    FontAwesomeIcons.camera,
    FontAwesomeIcons.film,
    FontAwesomeIcons.microphone,
    FontAwesomeIcons.fileLines,
  ];

  @override
  void initState() {
    super.initState();
    selectedValues = List<bool>.filled(hobbies.length, false);
    hobbiesJson = jsonEncode(selectedHobbies);
  }

  void _updateHobbiesJson() {
    setState(() {
      hobbiesJson = jsonEncode(selectedHobbies);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: Text(
                '9. Select Hobbies/Interests',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: hobbies.length,
                itemBuilder: (context, index) {
                  final hobby = hobbies[index];
                  final icon = hobbyIcons[index % hobbyIcons.length];

                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          selectedValues[index] = !selectedValues[index];
                          if (selectedValues[index]) {
                            selectedHobbies.add(hobby);
                          } else {
                            selectedHobbies.remove(hobby);
                          }
                          _updateHobbiesJson();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.purple.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                icon,
                                size: 25,
                                color: Colors.purple[800],
                              ),
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                hobby,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Checkbox(
                              value: selectedValues[index],
                              onChanged: (bool? value) {
                                if (value != null) {
                                  setState(() {
                                    selectedValues[index] = value;
                                    if (value) {
                                      selectedHobbies.add(hobby);
                                    } else {
                                      selectedHobbies.remove(hobby);
                                    }
                                    _updateHobbiesJson();
                                  });
                                }
                              },
                              activeColor: Colors.purple,
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // You can access the JSON string here:
                  print('Hobbies JSON: $hobbiesJson');

                  setProfileDataProvider.setHobbies(hobbiesJson);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactScreen()),
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
