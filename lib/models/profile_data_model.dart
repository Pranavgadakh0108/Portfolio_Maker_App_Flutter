class ProfileDataModel {
  int? id;
  String? profilePhoto;
  String? fullName;
  String? profession;
  String? bio;
  String? email;
  String? mobileNumber;
  String? address;
  String? linkedin;
  String? github;
  String? instagram;
  String? twitter;

  //page3
  String? skills;
  String? ratings;

  //page4
  String? degree;
  String? college;
  String? startYear;
  String? endYear;
  String? experience;
  String? achievement;

  //page5
  String? hasExperience;
  String? jobTitle;
  String? companyName;
  String? startDate;
  String? endDate;
  String? companyLocation;
  String? responsibilities;

  //page6
  String? projectTitle;
  String? projectDescription;
  String? projectTechstack;
  String? projectUrl;
  String? projectImg;

  //page7
  String? haveCertificate;
  String? certificateName;
  String? organizationName;
  String? issueDate;
  String? certificateUrl;
  String? certificateDescription;

  //page8
  String? haveAward;
  String? awardName;
  String? awardOrgName;
  String? awardIsuDate;
  String? awardDesc;

  //page9
  String? hobbies;
  //page10
  String? availability;
  String? contactMethod;
  String? coverLetter;

  ProfileDataModel({
    this.id,
    this.profilePhoto,
    this.fullName,
    this.profession,
    this.bio,
    this.email,
    this.mobileNumber,
    this.address,
    this.linkedin,
    this.github,
    this.instagram,
    this.twitter,

    this.skills,
    this.ratings,

    this.degree,
    this.college,
    this.startYear,
    this.endYear,
    this.experience,
    this.achievement,

    this.hasExperience,
    this.jobTitle,
    this.companyName,
    this.startDate,
    this.endDate,
    this.companyLocation,
    this.responsibilities,

    this.projectTitle,
    this.projectDescription,
    this.projectTechstack,
    this.projectUrl,
    this.projectImg,

    this.haveCertificate,
    this.certificateName,
    this.organizationName,
    this.issueDate,
    this.certificateDescription,
    this.certificateUrl,

    this.haveAward,
    this.awardName,
    this.awardOrgName,
    this.awardIsuDate,
    this.awardDesc,

    this.hobbies,

    this.availability,
    this.contactMethod,
    this.coverLetter,
  });

  factory ProfileDataModel.fromMap(Map<String, dynamic> map) {
    return ProfileDataModel(
      id: map['id'],
      profilePhoto: map['profile_photo'],
      fullName: map['full_name'],
      profession: map['profession'],
      bio: map['bio'],
      email: map['email'],
      mobileNumber: map['mobile_number'],
      address: map['address'],
      linkedin: map['linkedin'],
      github: map['github'],
      instagram: map['instagram'],
      twitter: map['twitter'],

      skills: map['skills'],
      ratings: map['ratings'],

      degree: map['degree'],
      college: map['college'],
      startYear: map['start_year'],
      endYear: map['end_year'],
      experience: map['experience'],
      achievement: map['achievement'],

      hasExperience: map['has_experience'],
      jobTitle: map['job_title'],
      companyName: map['company_name'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      companyLocation: map['company_location'],
      responsibilities: map['responsibilities'],

      projectTitle: map['project_title'],
      projectDescription: map['project_description'],
      projectTechstack: map['project_techstack'],
      projectUrl: map['project_url'],
      projectImg: map['project_img'],

      haveCertificate: map['have_certificate'],
      certificateName: map['certificate_name'],
      organizationName: map['organization_name'],
      issueDate: map['issue_date'],
      certificateUrl: map['certificate_url'],
      certificateDescription: map['certificate_description'],

      haveAward: map['have_award'],
      awardName: map['award_name'],
      awardOrgName: map['award_org_name'],
      awardIsuDate: map['award_isu_date'],
      awardDesc: map['award_desc'],

      hobbies: map['hobbies'],

      availability: map['availability'],
      contactMethod: map['contact_method'],
      coverLetter: map['cover_letter'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profile_photo': profilePhoto,
      'full_name': fullName,
      'profession': profession,
      'bio': bio,
      'email':email,
      'mobile_number': mobileNumber,
      'address': address,
      'linkedin': linkedin,
      'github': github,
      'instagram': instagram,
      'twitter': twitter,

      'skills': skills,
      'ratings': ratings,

      'degree': degree,
      'college': college,
      'start_year': startYear,
      'end_year': endYear,
      'experience': experience,
      'achievement': achievement,

      'has_experience': hasExperience,
      'job_title': jobTitle,
      'company_name': companyName,
      'start_date': startDate,
      'end_date': endDate,
      'company_location': companyLocation,
      'responsibilities': responsibilities,

      'project_title': projectTitle,
      'project_description': projectDescription,
      'project_techstack': projectTechstack,
      'project_url': projectUrl,
      'project_img': projectImg,

      'have_certificate': haveCertificate,
      'certificate_name': certificateName,
      'organization_name': organizationName,
      'issue_date': issueDate,
      'certificate_url': certificateUrl,
      'certificate_description': certificateDescription,

      'have_award': haveAward,
      'award_name': awardName,
      'award_org_name': awardOrgName,
      'award_isu_date': awardIsuDate,
      'award_desc': awardDesc,

      'hobbies': hobbies,

      'availability': availability,
      'contact_method': contactMethod,
      'cover_letter': coverLetter,
    };
  }

  factory ProfileDataModel.fromJson(Map<String, dynamic> map) {
    return ProfileDataModel.fromMap(map);
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}
