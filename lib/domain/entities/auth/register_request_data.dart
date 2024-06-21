class RegisterRequestData {
  String userName;
  String email;
  String? birthDate;
  String? gender;
  String? country;
  String? phoneNumber;
  String password;
  String confirmPassword;

  RegisterRequestData({
    required this.userName,
    required this.email,
    this.birthDate,
    this.gender,
    this.country,
    this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
