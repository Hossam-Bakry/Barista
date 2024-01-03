class RegisterRequestData {
  String userName;
  String email;
  String country;
  String phoneNumber;
  String password;
  String confirmPassword;

  RegisterRequestData({
    required this.userName,
    required this.email,
    required this.country,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
