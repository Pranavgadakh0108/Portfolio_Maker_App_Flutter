import 'package:flutter/material.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/ui/page4.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<bool?> selectedValues = List<bool?>.filled(skills.length, false);
  List<String> selectedSkills = [];
  String? selectedRatings;
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
                  color: Colors.black54,
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
                              selectedValues[index] ?? false
                                  ? selectedSkills.add(skill)
                                  : selectedSkills.remove(skill);
                            });
                          },
                        ),
                        if (selectedValues[index] ?? false)
                          Column(
                            children: ratings.map((rating) {
                              return RadioListTile<String>(
                                title: Text(rating),
                                value: rating,
                                groupValue: selectedRatings,
                                onChanged: (value) {
                                  setState(() {
                                    selectedRatings = value;
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
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
