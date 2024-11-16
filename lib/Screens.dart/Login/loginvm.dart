import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isLoading = false;
  Future<void> 
  login(BuildContext context) async {
    final url = Uri.parse('https://fakestoreapi.com/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": nameController.text,
        "password": passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Login successful: ${data['token']}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.body)));

      // You can navigate to a new screen or show a success message
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.body)));
      print("Login failed: ${response.body}");
      // Show an error message if login fails
    }
  }

 Future<Map<String, dynamic>> signUp(BuildContext context) async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String address = addressController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
     
    }

    // Show loading spinner
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'username': name,
          'password': password,
          'name': {
            'firstname': name.split(' ').first,
            'lastname': name.split(' ').last,
          },
          'address': {
            'city': 'Sample City',
            'street': address,
            'number': 3,
            'zipcode': '12345-6789',
            'geolocation': {'lat': '-37.3159', 'long': '81.1496'},
          },
          'phone': '123-456-7890'
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup successful")),
        );
        print("dataaaaa" + data.toString());
        clearFields();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed. Please try again.")),
        );
      }
    } catch (error) {
      print("Error during signup: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again later.")),
      );
    } finally {
      // Hide loading spinner
      isLoading = false;
      notifyListeners();
    }
     return {
    'success': true, // or false based on your logic
    'error': 'Optional error message'
  };
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    addressController.clear();
    notifyListeners();
  }
}
