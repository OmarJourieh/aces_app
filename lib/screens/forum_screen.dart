import 'package:aces_app/providers/auths_provider.dart';
import 'package:aces_app/providers/forum_provider.dart';
import 'package:aces_app/screens/add_post_screen.dart';
import 'package:aces_app/screens/single_post_screen.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:aces_app/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumScreen extends StatelessWidget {
  ForumScreen({Key? key}) : super(key: key);
  bool clickedDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          right: 5,
          bottom: 5,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddPostScreen(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.green[900],
        ),
      ),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SinglePostScreen(
                            post: snapshot.data[index],
                          ),
                        ),
                      );
                    },
                    title: Text(
                      snapshot.data[index].title ?? "Title",
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
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "Posted by: ${snapshot.data[index].user.name}",
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green[900]!, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    trailing: snapshot.data[index].userId ==
                            Provider.of<AuthsProvider>(context).user!.id
                        ? IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: Text(
                                    "Are you sure you want to delete this post?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (clickedDelete == false) {
                                          clickedDelete = true;
                                          await Provider.of<ForumProvider>(
                                                  context,
                                                  listen: false)
                                              .deletePost(
                                                  postId:
                                                      snapshot.data[index].id);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (_) => ForumScreen(),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text("Yes"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[900],
                            ),
                          )
                        : Icon(
                            Icons.ac_unit,
                            color: Colors.white,
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
