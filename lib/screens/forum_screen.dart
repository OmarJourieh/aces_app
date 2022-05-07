import 'package:aces_app/providers/forum_provider.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:aces_app/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomNavBar(context),
      backgroundColor: Colors.white,
      appBar:
          getAppBar(title: "Community", context: context, logoutButton: true),
      body: FutureBuilder(
        future:
            Provider.of<ForumProvider>(context, listen: false).getAllPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ListTile(
                    onTap: () {
                      print("COMMENTS:");
                      print(snapshot.data[index].comment[0]);
                    },
                    title: Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data[index].content.length > 50
                              ? snapshot.data[index].content.substring(0, 50) +
                                  "..."
                              : snapshot.data[index].content,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Posted by: ${snapshot.data[index].user.name}",
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green[900]!, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green[900],
              ),
            );
          }
        },
      ),
    );
  }
}
