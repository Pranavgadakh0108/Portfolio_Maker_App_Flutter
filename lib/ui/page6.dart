import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_creator/ui/page7.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:portfolio_creator/widget/project_img.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  var projectNameController = TextEditingController();
  var projDescController = TextEditingController();
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
                        '6. Projects',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    CustomTextFormField(
                      controller: projectNameController,
                      hintText: "Enter Your Project Title",
                      icon: Icons.task_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Project Title",
                      onChanged: (value) {
                        setState(() {
                          projectNameController.text = value;
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
                      controller: projDescController,
                      maxLines: 3,
                      hintText: "Enter Your Project Description",
                      icon: Icons.description_outlined,
                      keyboardType: TextInputType.text,
                      labelText: "Project Description",
                      onChanged: (value) {
                        setState(() {
                          projDescController.text = value;
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 1,
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
                              builder: (context) => Certifications(),
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
