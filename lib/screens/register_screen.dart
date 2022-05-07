import 'package:aces_app/models/user.dart';
import 'package:aces_app/providers/auths_provider.dart';
import 'package:aces_app/screens/login_screen.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final String destination;
  const RegisterScreen({Key? key, required this.destination}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  String? password;
  String? name;

  @override
  Widget build(BuildContext context) {
    print("Name: $name");
    print("Email: $email");
    print("Password: $password");
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(title: "Join ACES", context: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: height * 0.2),
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.green[900]!),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.green[900]!),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.green[900]!),
                  borderRadius: BorderRadius.circular(5),
                ),
                // hintText: "Email",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.green[900]!),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.green[900]!),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.green[900]!),
                  borderRadius: BorderRadius.circular(5),
                ),
                // hintText: "Email",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green[900]!),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.green[900]!),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.green[900]!),
                  borderRadius: BorderRadius.circular(5),
                ),
                // hintText: "Email",
              ),
            ),
            SizedBox(height: 40),
            TextButton(
              style: ButtonStyle(
                // padding: EdgeInsets.zero,
                backgroundColor: MaterialStateProperty.all(Colors.grey[350]),
              ),
              child: Text(
                "Sign up",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                String response =
                    await Provider.of<AuthsProvider>(context, listen: false)
                        .register(
                  User(
                    email: email!.trim().toLowerCase(),
                    password: password!.trim(),
                    name: name!.trim(),
                  ),
                );
                if (response == "success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Account created successfully!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_) =>
                            LoginScreen(destination: widget.destination)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Invalid data",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.center,
              child: Text("Already have an account?"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Sign in",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
