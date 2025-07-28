import 'package:flutter/material.dart';
import 'package:portfolio_creator/models/profile_data_model.dart';

class SetProfileDataProvider extends ChangeNotifier {
  final ProfileDataModel _profile = ProfileDataModel();

  ProfileDataModel? get profile => _profile;

  int? get id => _profile.id;
  String? get profilePhoto => _profile.profilePhoto;
  String? get fullName => _profile.fullName;
  String? get profession => _profile.profession;
  String? get bio => _profile.bio;
  String? get email => _profile.email;
  String? get mobileNumber => _profile.mobileNumber;
  String? get address => _profile.address;
  String? get linkedin => _profile.linkedin;
  String? get github => _profile.github;
  String? get instagram => _profile.instagram;
  String? get twitter => _profile.twitter;

  String? get skills => _profile.skills;
  String? get ratings => _profile.ratings;

  //page4
  String? get degree => _profile.degree;
  String? get college => _profile.college;
  String? get startYear => _profile.startYear;
  String? get endYear => _profile.endYear;
  String? get experience => _profile.experience;
  String? get achievement => _profile.achievement;

  //page5
  String? get hasExperience => _profile.hasExperience;
  String? get jobTitle => _profile.jobTitle;
  String? get companyName => _profile.companyName;
  String? get startDate => _profile.startDate;
  String? get endDate => _profile.endDate;
  String? get companyLocation => _profile.companyLocation;
  String? get responsibilities => _profile.responsibilities;

  //page6
  String? get projectTitle => _profile.projectTitle;
  String? get projectDescription => _profile.projectDescription;
  String? get projectTechstack => _profile.projectTechstack;
  String? get projectUrl => _profile.projectUrl;
  String? get projectImg => _profile.projectImg;

  //page7
  String? get haveCertificate => _profile.haveCertificate;
  String? get certificateName => _profile.certificateName;
  String? get organizationName => _profile.organizationName;
  String? get issueDate => _profile.issueDate;
  String? get certificateUrl => _profile.certificateUrl;
  String? get certificateDescription => _profile.certificateDescription;

  //page8
  String? get haveAward => _profile.haveAward;
  String? get awardName => _profile.awardName;
  String? get awardOrgName => _profile.awardOrgName;
  String? get awardIsuDate => _profile.awardIsuDate;
  String? get awardDesc => _profile.awardDesc;

  //page9
  String? get hobbies => _profile.hobbies;

  //page10
  String? get availability => _profile.availability;
  String? get contactMethod => _profile.contactMethod;
  String? get coverLetter => _profile.coverLetter;

  void setID(int value) {
    _profile.id = value;
    notifyListeners();
  }

  void setProfilePhoto(String? value) {
    _profile.profilePhoto = value;
    notifyListeners();
  }

  void setFullName(String? value) {
    _profile.fullName = value;
    notifyListeners();
  }

  void setProfession(String? value) {
    _profile.profession = value;
    notifyListeners();
  }

  void setBio(String? value) {
    _profile.bio = value;
    notifyListeners();
  }

  void setEmail(String? value){
    _profile.email = value;
    notifyListeners();
  }

  void setMobileNumber(String? value) {
    _profile.mobileNumber = value;
    notifyListeners();
  }

  void setAddress(String? value) {
    _profile.address = value;
    notifyListeners();
  }

  void setLinkedIn(String? value) {
    _profile.linkedin = value;
    notifyListeners();
  }

  void setGithub(String? value) {
    _profile.github = value;
    notifyListeners();
  }

  void setInstagram(String? value) {
    _profile.instagram = value;
    notifyListeners();
  }

  void setTwitter(String? value) {
    _profile.twitter = value;
    notifyListeners();
  }

  void setSkills(String? value) {
    _profile.skills = value;
    notifyListeners();
  }

  void setRatings(String? value) {
    _profile.ratings = value;
    notifyListeners();
  }

  //page4
  void setDegree(String? value) {
    _profile.degree = value;
    notifyListeners();
  }

  void setCollege(String? value) {
    _profile.college = value;
    notifyListeners();
  }

  void setStartYear(String? value) {
    _profile.startYear = value;
    notifyListeners();
  }

  void setEndYear(String? value) {
    _profile.endYear = value;
    notifyListeners();
  }

  void setExperience(String? value) {
    _profile.experience = value;
    notifyListeners();
  }

  void setAchievement(String? value) {
    _profile.achievement = value;
    notifyListeners();
  }

  void setHasExperience(String? value) {
    _profile.hasExperience = value;
    notifyListeners();
  }

  void setJobTitle(String? value) {
    _profile.jobTitle = value;
    notifyListeners();
  }

  void setCompanyName(String? value) {
    _profile.companyName = value;
    notifyListeners();
  }

  void setStartDate(String? value) {
    _profile.startDate = value;
    notifyListeners();
  }

  void setEndDate(String? value) {
    _profile.endDate = value;
    notifyListeners();
  }

  void setCompanyLocation(String? value) {
    _profile.companyLocation = value;
    notifyListeners();
  }

  void setResponsibilities(String? value) {
    _profile.responsibilities = value;
    notifyListeners();
  }

  void setProjectTitle(String? value) {
    _profile.projectTitle = value;
    notifyListeners();
  }

  void setProjectDescription(String? value) {
    _profile.projectDescription = value;
    notifyListeners();
  }

  void setProjectTechstack(String? value) {
    _profile.projectTechstack = value;
    notifyListeners();
  }

  void setProjectUrl(String? value) {
    _profile.projectUrl = value;
    notifyListeners();
  }

  void setProjectImg(String? value) {
    _profile.projectImg = value;
    notifyListeners();
  }

  void setHaveCertificate(String? value) {
    _profile.haveCertificate = value;
    notifyListeners();
  }

  void setCertificateName(String? value) {
    _profile.certificateName = value;
    notifyListeners();
  }

  void setOrganizationName(String? value) {
    _profile.organizationName = value;
    notifyListeners();
  }

  void setIssueDate(String? value) {
    _profile.issueDate = value;
    notifyListeners();
  }

  void setCertificateUrl(String? value) {
    _profile.certificateUrl = value;
    notifyListeners();
  }

  void setCertificateDescription(String? value) {
    _profile.certificateDescription = value;
    notifyListeners();
  }

  void setHaveAward(String? value) {
    _profile.haveAward = value;
    notifyListeners();
  }

  void setAwardName(String? value) {
    _profile.awardName = value;
    notifyListeners();
  }

  void setAwardOrgName(String? value) {
    _profile.awardOrgName = value;
    notifyListeners();
  }

  void setAwardIsuDate(String? value) {
    _profile.awardIsuDate = value;
    notifyListeners();
  }

  void setAwardDesc(String? value) {
    _profile.awardDesc = value;
    notifyListeners();
  }

  void setHobbies(String? value) {
    _profile.hobbies = value;
    notifyListeners();
  }

  void setAvailability(String? value) {
    _profile.availability = value;
    notifyListeners();
  }

  void setContactMethod(String? value) {
    _profile.contactMethod = value;
    notifyListeners();
  }

  void setCoverLetter(String? value) {
    _profile.coverLetter = value;
    notifyListeners();
  }
}
