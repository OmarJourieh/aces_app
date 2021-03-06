import 'package:aces_app/models/user.dart';
import 'package:aces_app/providers/auths_provider.dart';
import 'package:aces_app/screens/forum_screen.dart';
import 'package:aces_app/screens/profile_screen.dart';
import 'package:aces_app/screens/register_screen.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final String destination;
  LoginScreen({Key? key, required this.destination}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    print(email);
    print(password);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(title: "Welcome Back", context: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: height * 0.2),
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
                "Sign in",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                String response =
                    await Provider.of<AuthsProvider>(context, listen: false)
                        .login(
                  User(
                    email: email!.trim().toLowerCase(),
                    password: password!.trim(),
                  ),
                );
                if (response == "success") {
                  if (widget.destination == "profile") {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(),
                      ),
                    );
                  } else if (widget.destination == "forum") {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ForumScreen(),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Incorrect credentials",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Text("Don't have an account?"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RegisterScreen(
                      destination: widget.destination,
                    ),
                  ),
                );
              },
              child: Text(
                "Sign up",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
