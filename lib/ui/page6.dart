import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_creator/ui/page2.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:portfolio_creator/widget/project_img.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

  final GlobalKey<FormState> _globalKey = GlobalKey();
  var nameController = TextEditingController();
  var descController = TextEditingController();
  var techStackController = TextEditingController();
  var projectUrlController = TextEditingController();

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
                        '6. Projects',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    
                    CustomTextFormField(
                      controller: nameController,
                      hintText: "Enter Your Project Title",
                      icon: Icons.task_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Project Title",
                      onChanged: (value) {
                        setState(() {
                          nameController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Project Title first...";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: descController,
                      maxLines: 3,
                      hintText: "Enter Your Project Description",
                      icon: Icons.description_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Project Description",
                      onChanged: (value) {
                        setState(() {
                          descController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Project Description first...";
                        }
                        return null;
                      },
                    ),

                    CustomTextFormField(
                      controller: techStackController,
                      hintText: "Enter Your Project TechStack",
                      icon: Icons.code,
                      keyboardType: TextInputType.text,
                      labelText: "Project TechStack",
                      onChanged: (value) {
                        setState(() {
                          techStackController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the Project TechStack first...";
                        }
                        return null;
                      },
                    ),
                    
                    

                    CustomTextFormField(
                      controller: projectUrlController,
                      hintText: "Enter Your Project URL",
                      icon: FontAwesomeIcons.laptopCode,
                      keyboardType: TextInputType.text,
                      labelText: "Project URL",
                      onChanged: (value) {
                        setState(() {
                          projectUrlController.text = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Project URL First..";
                        }
                        return null;
                      },
                    ),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 5),
                          Text('Upload Project Image'),
                          SizedBox(height: 5),
                          SizedBox(
                            height: 140,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ProjectImg(),
                          ),
                        ],
                      ),
                    ),
                    

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SocialLinks(),
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

