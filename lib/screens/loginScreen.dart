// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../services.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  final formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    if (formKey.currentState!.validate()) {
      // Perform login action
      setState(() async {
        // await ApiService.instance
        //     .login(phoneController.text, passwordController.text, "62");
        String? token = await ApiService.instance
            .login(phoneController.text, passwordController.text, "62");

        if (token != null) {
          // print('Login successful. Token: $token');
          // You can now use the token for authenticated requests
        } else {
          // print('Login failed');
        }
        _btnController.success();
        print("nice");
        _btnController.reset();
      });
    } else {
      _btnController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Shader lineargradient = const LinearGradient(colors: <Color>[
      Color.fromARGB(255, 186, 212, 19),
      Color.fromARGB(255, 172, 113, 37),
    ]).createShader(const Rect.fromLTWH(0, 0, 200, 70));

    final phone = TextFormField(
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mohon diisi menggunakan Phone Number yang valid';
        }
        if (!RegExp(r'^[1-9][0-9]{7,15}$').hasMatch(value)) {
          return 'Phone number must be 8-16 digits long and not start with 0';
        }
        return null;
      },
      autofocus: false,
      controller: phoneController,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Phone Number",
        prefixText: '+62 ',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: InputBorder.none,
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mohon diisi menggunakan Password yang valid';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: InputBorder.none,
      ),
      obscureText: isPasswordVisible,
    );

    final loginButton = RoundedLoadingButton(
      color: const Color.fromARGB(255, 186, 212, 19),
      controller: _btnController,
      onPressed: _doSomething,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 186, 212, 19),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Center(
          child: Text("Masuk", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 212, 19),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(alignment: Alignment.center, children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 70),
                child: const Image(
                  width: 200,
                  image: AssetImage(
                    "assets/icon2.png",
                  ),
                ),
              ),
            ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 25, 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Masuk",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: phone,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: password,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            loginButton,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
