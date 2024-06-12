// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:vec_habib/screens/menu.dart';
import '../services.dart';
import '../token_porvider.dart';

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
      setState(() {
        _btnController.start();
      });

      try {
        // print('Attempting to log in...');
        String? token = await ApiService.instance
            .login(phoneController.text, passwordController.text, "62");

        setState(() {
          _btnController.stop();
        });

        if (token != null) {
          // Save the token using Provider
          Provider.of<TokenProvider>(context, listen: false).setToken(token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MenuScreen(),
            ),
          );
        } else {
          _showErrorDialog('Login failed');
        }
      } catch (e) {
        // print('Error during login: $e');
        setState(() {
          _btnController.stop();
        });
        _showErrorDialog('An error occurred: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
          _btnController.stop();
          return 'Mohon diisi menggunakan Password yang valid';
        }
        if (value.length < 8) {
          _btnController.stop();
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
            height: MediaQuery.of(context).size.width * 0.9,
            child: Stack(alignment: Alignment.center, children: [
              Transform.translate(
                offset: const Offset(0.0, 150.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      child: const Image(
                        width: 100,
                        image: AssetImage(
                          "assets/icon.png",
                        ),
                      ),
                    ),
                  ],
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
