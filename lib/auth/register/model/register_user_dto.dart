class RegisterUserDto {
  final String uid;
  final String password;
  final String firstName;
  final String lastName;
  final String titleCode;

  RegisterUserDto({
    required this.uid,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.titleCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'titleCode': titleCode,
    };
  }
}
