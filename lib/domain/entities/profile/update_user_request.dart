class UpdateprofileDataRequest {
  final String userName;
  final String email;
  final String phoneNumber;
  final String imagePath;
  final String birthDate;
  final String gender;
  final String country;
  final String originalCountry;

  UpdateprofileDataRequest({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.imagePath,
    required this.birthDate,
    required this.gender,
    required this.country,
    required this.originalCountry,
  });

  @override
  String toString() {
    return 'UpdateprofileDataRequest{userName: $userName, email: $email, phoneNumber: $phoneNumber, imagePath: $imagePath, birthDate: $birthDate, gender: $gender, country: $country, originalCountry: $originalCountry}';
  }
}
