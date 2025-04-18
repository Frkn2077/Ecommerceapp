class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String id) {
    return AppUser(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'phone': phone, 'address': address};
  }
}
