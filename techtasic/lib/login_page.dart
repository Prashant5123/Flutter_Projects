import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techtasic/register_screen.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/login'),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    print(response.body); // Just for demo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          ElevatedButton(onPressed: loginUser, child: Text('Login')),
          TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage())),
              child: Text("Don't have an account? Register")
          ),
        ],
      ),
    );
  }
}
