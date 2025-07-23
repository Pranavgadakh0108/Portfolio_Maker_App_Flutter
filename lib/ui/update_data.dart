import 'package:flutter/material.dart';
import 'package:portfolio_creator/models/profile_data_model.dart';
import 'package:portfolio_creator/provider/profile_data_provider.dart';
import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:portfolio_creator/ui/view_profile.dart';
import 'package:portfolio_creator/widget/custom_form_field.dart';
import 'package:provider/provider.dart';

class UpdateData extends StatefulWidget {
  final int? id;

  const UpdateData({super.key, required this.id});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  ProfileDataModel? _profile;
  bool _isLoading = true;

  int providerId = 0;

  @override
  void initState() {
    super.initState();
    getId();
    getDataById(widget.id ?? 0);
  }

  Future<void> getId() async {
    final setProfileData = Provider.of<SetProfileDataProvider>(
      context,
      listen: false,
    );

    setState(() {
      final providerId = setProfileData.id;
    });
  }

  Future<void> getDataById(int id) async {
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);
    _profile = await provider.getAllPortfolioProfileById(id, context);

    nameController.text = _profile?.fullName ?? "";
    professionController.text = _profile?.profession ?? "";
    mobileController.text = _profile?.mobileNumber ?? "";
    addressController.text = _profile?.address ?? "";

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> updateDataById(int id) async {
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);

    final updatedProfile = ProfileDataModel(
      id: widget.id,
      fullName: nameController.text,
      profession: professionController.text,
      mobileNumber: mobileController.text,
      address: addressController.text,
    );

    await provider
        .updateProfileProvider(id, updatedProfile.toMap(), context)
        .then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ViewProfile()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // print('Fetching data for ID: ${widget.id}');
    // print('Received profile: $_profile');
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : Form(
              key: _globalKey,
              child: Column(
                children: [
                   SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Update Details',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  CustomTextFormField(
                    controller: nameController,
                    hintText: "Enter your name",
                    icon: Icons.account_circle_outlined,
                    labelText: "Name",
                    validator: (value) {
                      if (value == null) {
                        return "enter the name first";
                      }
                      return null;
                    },
                  ),

                  CustomTextFormField(
                    controller: professionController,
                    hintText: "Enter your profession",
                    icon: Icons.work_outline_outlined,
                    labelText: 'Profession',
                    validator: (value) {
                      if (value == null) {
                        return "enter the profession first";
                      }
                      return null;
                    },
                  ),

                  CustomTextFormField(
                    controller: mobileController,
                    hintText: "Enter your Mobile Number",
                    icon: Icons.smartphone,
                    labelText: "Mobile",
                    validator: (value) {
                      if (value == null) {
                        return "enter the mobile No. first";
                      }
                      return null;
                    },
                  ),

                  CustomTextFormField(
                    controller: addressController,
                    hintText: "Enter your address",
                    icon: Icons.location_on,
                    labelText: "Address",
                    validator: (value) {
                      if (value == null) {
                        return "enter the address first";
                      }
                      return null;
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        updateDataById(widget.id ?? 0);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
    );
  }
}
