import 'package:ecommerce/CustomWidgets/custom_button.dart';
import 'package:ecommerce/Screens.dart/Login/login._screen.dart';
import 'package:ecommerce/Screens.dart/Login/loginvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, vm, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Stack(
                children: [
                  // Positioned Back Arrow
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  // Main Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40), // Space for the back arrow
                      Image.asset('assets/login.png', height: 100),
                      SizedBox(height: 20),
                      Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      10.height,
                      Text(
                        'Sign up to get started',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      30.height, // Full Name Field
                      SizedBox(
                        height: 43,
                        child: TextField(
                          focusNode: vm.nameFocusNode,
                          controller: vm.nameController,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            hintStyle: TextStyle(fontSize: 14),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey[600],
                              size: 17,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                           onSubmitted: (_) {
                        // Move focus to the password field
                        FocusScope.of(context).requestFocus(vm.emailFocusNode);
                      },
                        ),
                      ),
                     const SizedBox(height: 20),
                      // Email Field
                      SizedBox(
                        height: 43,
                        child: TextField(
                          focusNode: vm.emailFocusNode,
                          controller: vm.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email ',
                            hintStyle: TextStyle(fontSize: 14),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey[600],
                              size: 17,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                           onSubmitted: (_) {
                        // Move focus to the password field
                        FocusScope.of(context).requestFocus(vm.addressFocusNode);
                      },
                        ),
                      ),
                      20.height, // Password Field
                      SizedBox(
                        height: 43,
                        child: TextField(
                          focusNode: vm.addressFocusNode,
                          controller: vm.addressController,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(fontSize: 14),
                            prefixIcon: Icon(Icons.details, color: Colors.grey[600], size: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                           onSubmitted: (_) {
                        // Move focus to the password field
                        FocusScope.of(context).requestFocus(vm.passwordFocusNode);
                      },
                        ),
                      ),
                      20.height, // Confirm Password Field
                      SizedBox(
                        height: 43,
                        child: TextField(
                          focusNode: vm.passwordFocusNode,
                          controller: vm.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: ' Password',
                            hintStyle: TextStyle(fontSize: 14),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[600],
                              size: 17,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                           onSubmitted: (_) {
                        // Move focus to the password field
                        FocusScope.of(context).requestFocus(vm.passwordFocusNode);
                      },
                        ),
                      ),
                      30.height, // Sign Up Button
                      CustomButton(
                        width: double.infinity,
                        text: "Sign Up",
                        onPressed: () {
                          // vm.signUp(context).then((value) => value['']);
                          // Example: Navigation to LoginScreen on successful sign-up
                          vm.signUp(context).then((value) {
                            if (value['success'] == true) {
                              // Check if sign-up was successful
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            } else {
                              // Handle failure (e.g., show error message)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Sign-up failed: ${value['error']}')),
                              );
                            }
                          });
                        },
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      ),
                      20.height, // Already have an account?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Go back to login screen
                            },
                            child: Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
