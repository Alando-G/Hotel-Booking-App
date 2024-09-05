// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _phoneNumber;
  bool _isEditing = false;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _email = user.email;
        _imageUrl = user.photoURL;
      });

      // Fetch additional user data from Firestore
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          _name = data['name'];
          _phoneNumber = data['phoneNumber'];
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _name,
          'email': _email,
          'phoneNumber': _phoneNumber,
        }, SetOptions(merge: true));

        setState(() {
          _isEditing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isEditing ? _buildEditForm() : _buildProfileView(),
      ),
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          _buildTextField('Name', (value) => _name = value),
          const SizedBox(height: 20),
          _buildTextField('Email', (value) => _email = value),
          const SizedBox(height: 20),
          _buildTextField('Phone Number', (value) => _phoneNumber = value),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Save Profile'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_imageUrl != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(_imageUrl!),
          )
        else
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        const SizedBox(height: 20),
        Text(
          _name ?? 'No Name',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          _email ?? 'No Email',
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Text(
          _phoneNumber ?? 'No Phone Number',
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isEditing = true;
            });
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved) {
    return TextFormField(
      initialValue: label == 'Name' ? _name : label == 'Email' ? _email : _phoneNumber,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
