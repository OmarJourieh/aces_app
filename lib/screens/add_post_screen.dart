import 'package:aces_app/models/post.dart';
import 'package:aces_app/providers/auths_provider.dart';
import 'package:aces_app/providers/forum_provider.dart';
import 'package:aces_app/screens/forum_screen.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  String title = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
          right: 10,
          bottom: 10,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            if (title != "" && content != "") {
              Post post = Post(
                title: title,
                content: content,
                userId:
                    Provider.of<AuthsProvider>(context, listen: false).user!.id,
              );
              await Provider.of<ForumProvider>(context, listen: false)
                  .addPost(post);
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => ForumScreen(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Both fields are required",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          backgroundColor: Colors.green[900],
          child: const Icon(Icons.check),
        ),
      ),
      appBar: getAppBar(title: "Add post", context: context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView(
          children: [
            TextField(
              onChanged: (value) {
                title = value;
              },
              decoration: InputDecoration(
                labelText: 'Title',
                alignLabelWithHint: true,
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
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                content = value;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              decoration: InputDecoration(
                labelText: 'Body',
                alignLabelWithHint: true,
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
          ],
        ),
      ),
    );
  }
}
