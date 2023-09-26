class ThirdPartyUser {
  final String name;
  final String email;
  final String thirdPartyToken;
  final String thirdParty;
  final String? token;
  final String phone;
  final String deviceId;
  final String? dob;

  ThirdPartyUser({
    this.dob,
    required this.thirdPartyToken,
    required this.thirdParty,
    this.token,
    required this.email,
    required this.deviceId,
    required this.name,
    required this.phone,
  });
}
