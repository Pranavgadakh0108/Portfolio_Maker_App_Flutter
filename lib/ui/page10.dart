import 'package:flutter/material.dart';
import 'package:portfolio_creator/data/appdata.dart';
import 'package:portfolio_creator/ui/page11.dart';

class HobbiesPage extends StatefulWidget {
  const HobbiesPage({super.key});

  @override
  State<HobbiesPage> createState() => _HobbiesPageState();
}

class _HobbiesPageState extends State<HobbiesPage> {
  List<bool?> selectedValues = List<bool?>.filled(hobbies.length, false);
  List<String> selectedHobbies = [];
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
                '10. Select Hobbies/Interests',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: hobbies.length,
                itemBuilder: (context, index) {
                  final hobby = hobbies[index];
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text(hobby),
                          value: selectedValues[index],
                          activeColor: Colors.purple,
                          checkColor: Colors.white,
                          controlAffinity: ListTileControlAffinity.leading,
                          side: BorderSide(color: Colors.purple),
                          onChanged: (value) {
                            setState(() {
                              selectedValues[index] = value;
                              selectedValues[index] ?? false
                                  ? selectedHobbies.add(hobby)
                                  : selectedHobbies.remove(hobby);
                            });
                          },
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
                    MaterialPageRoute(builder: (context) => ContactScreen()),
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