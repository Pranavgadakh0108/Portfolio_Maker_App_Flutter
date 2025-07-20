// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:portfolio_creator/database/database_helper.dart';
import 'package:portfolio_creator/models/profile_data_model.dart';

class ProfileDataProvider extends ChangeNotifier {
  ProfileDataModel? _profile;

  List<ProfileDataModel?> _profiles = [];

  ProfileDataModel? get profile => _profile;

  List<ProfileDataModel?> get profiles => _profiles;

  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> insertPortfolioProfile(
    BuildContext context,
    ProfileDataModel? profile,
  ) async {
    try {
      int id = await databaseHelper.insertProfile(profile!.toMap());

      // _profile!.id == id;
      // _profile!.id = id;
      if (id > 0) {
        _profile = profile;
        notifyListeners();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Profile Posted Successfully")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile Posting is Unsuccessfully")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Occured: $e")));
    }
  }

  Future<void> getAllPortfolioProfiles(BuildContext context) async {
    try {
      final dataList = await databaseHelper.getAllProfiles();
      if (dataList.isNotEmpty) {
        _profiles = dataList.map((data) {
          return ProfileDataModel.fromMap(data);
        }).toList();
        notifyListeners();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("No Data Availabel")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Occured: $e")));
    }
  }

  // Future<void> getAllPortfolioProfiles() async {
  //   final dataList = await databaseHelper.getAllProfiles();
  //   if (dataList.isNotEmpty) {
  //     _profiles = dataList
  //         .map((data) => ProfileDataModel.fromMap(data))
  //         .toList();
  //   } else {
  //     _profiles = [];
  //   }
  //   notifyListeners();
  // }

  Future<void> getAllPortfolioProfileById(int id, BuildContext context) async {
    try {
      final data = await databaseHelper.getProfileById(id);
      if (_profile?.id == id && data != null) {
        _profile = ProfileDataModel.fromMap(data);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("No Data Availabel")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Occured: $e")));
    }
  }

  Future<void> updateProfileProvider(
    int id,
    String field,
    dynamic value,
    BuildContext context,
  ) async {
    try {
      await databaseHelper.updateProfile(id, {field: value});

      if (_profile?.id == id) {
        final updatedMap = _profile?.toMap();
        updatedMap?[field] = value;

        _profile = ProfileDataModel.fromMap(updatedMap!);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Profile Updated Successfully")));
        notifyListeners();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Unable to update data")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Occured: $e")));
    }
  }

  Future<void> deletePortfolioProfile(int id, BuildContext context) async {
    try {
      await databaseHelper.deleteProfile(id);
      if (_profile != null || _profile?.id == id) {
        _profile = null;
        notifyListeners();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Unable to Delete Data")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Occured: $e")));
    }
  }
}
