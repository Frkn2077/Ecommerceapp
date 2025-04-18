import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _userService.getUser();
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _addressController.text = user.address;
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final user = AppUser(
        id: _userService.userId,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
      );
      await _userService.updateUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bilgiler kaydedildi')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(title: const Text("Profilim")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Ad Soyad"),
                validator: (value) =>
                    value!.isEmpty ? "Ad soyad girin" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "E-posta"),
                validator: (value) =>
                    value!.isEmpty ? "E-posta girin" : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Telefon"),
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Adres"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
