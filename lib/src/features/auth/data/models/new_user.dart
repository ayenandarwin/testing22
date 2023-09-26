class NewUser {
  final String name;
  final String email;
  final String password;
  final String dob;
  final String role;
  final String phone;
  final String deviceId;

  NewUser(
      {required this.email,
      required this.password,
      required this.deviceId,
      required this.dob,
      required this.name,
      required this.phone,
      required this.role});
}
