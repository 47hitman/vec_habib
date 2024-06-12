import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Dio _dio = ApiService.instance.dio;
  bool _isLoading = false;

  void _updateProfile() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final formData = _formKey.currentState?.value;

      try {
        final response = await _dio.post('/api/v1/user/profile', data: {
          'name': formData!['name'],
          'email': formData['email'],
          'gender': formData['gender'],
          'date_of_birth': formData['date_of_birth'].toString(),
          'height': int.parse(formData['height']),
          'weight': int.parse(formData['weight']),
          '_method': 'PUT',
        });

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to update profile')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Name'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              FormBuilderDropdown(
                name: 'gender',
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['laki_laki', 'perempuan']
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderDateTimePicker(
                name: 'date_of_birth',
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'height',
                decoration: const InputDecoration(labelText: 'Height'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer(),
                  FormBuilderValidators.min(0),
                ]),
                keyboardType: TextInputType.number,
              ),
              FormBuilderTextField(
                name: 'weight',
                decoration: const InputDecoration(labelText: 'Weight'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer(),
                  FormBuilderValidators.min(0),
                ]),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _updateProfile,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
