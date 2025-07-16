class ProfileDataModel {
  final int? id;
  final String? profilePhoto;
  final String? fullName;
  final String? profession;
  final String? bio;
  final String? mobileNumber;
  final String? address;
  final String? linkedin;
  final String? github;
  final String? instagram;
  final String? twitter;

  ProfileDataModel({
    required this.id,
    required this.profilePhoto,
    required this.fullName,
    required this.profession,
    required this.bio,
    required this.mobileNumber,
    required this.address,
    required this.linkedin,
    required this.github,
    required this.instagram,
    required this.twitter,
  });

  factory ProfileDataModel.fromMap(Map<String, dynamic> map) {
    return ProfileDataModel(
      id: map['id'],
      profilePhoto: map['profile_photo'],
      fullName: map['full_name'],
      profession: map['profession'],
      bio: map['bio'],
      mobileNumber: map['mobile_number'],
      address: map['address'],
      linkedin: map['linkedin'],
      github: map['github'],
      instagram: map['instagram'],
      twitter: map['twitter'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profile_photo': profilePhoto,
      'full_name': fullName,
      'profession': profession,
      'bio': bio,
      'mobile_number': mobileNumber,
      'address': address,
      'linkedin': linkedin,
      'github': github,
      'instagram': instagram,
      'twitter': twitter,
    };
  }

  factory ProfileDataModel.fromJson(Map<String, dynamic> map) {
    return ProfileDataModel.fromMap(map);
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}
