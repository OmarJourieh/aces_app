import 'package:aces_app/models/comment.dart';
import 'package:aces_app/models/post.dart';
import 'package:aces_app/providers/auths_provider.dart';
import 'package:aces_app/providers/forum_provider.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePostScreen extends StatelessWidget {
  final Post post;
  SinglePostScreen({Key? key, required this.post}) : super(key: key);
  String comment = "";
  bool submitted = false;
  bool clickedDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: post.title ?? "Title", context: context),
      body: FutureBuilder(
        future: Provider.of<ForumProvider>(context, listen: false)
            .getPostById(id: post.id!),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    post.content!,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Text(
                    "Created by: ${post.user!.name}",
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Text(
                    "${post.createdAt}",
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Divider(
                  height: 50,
                  indent: 20,
                  endIndent: 20,
                  thickness: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: ListView.builder(
                      itemCount: snapshot.data.comment.length,
                      itemBuilder: (context, index) {
                        if (post.comment == null) {
                          return Center(
                            child: Text(
                              "No comments",
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(
                                  snapshot.data.comment[index].user.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    // fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data.comment![index].content!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: snapshot.data.comment[index].userId ==
                                        Provider.of<AuthsProvider>(context)
                                            .user!
                                            .id
                                    ? IconButton(
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              content: Text(
                                                "Are you sure you want to delete this comment?",
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
                                                    if (clickedDelete ==
                                                        false) {
                                                      clickedDelete = true;
                                                      await Provider.of<
                                                                  ForumProvider>(
                                                              context,
                                                              listen: false)
                                                          .deleteComment(
                                                        commentId: snapshot.data
                                                            .comment[index].id,
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              SinglePostScreen(
                                                            post: post,
                                                          ),
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
                                    : IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.ac_unit,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                              Divider(),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    onEditingComplete: () async {
                      print(Provider.of<AuthsProvider>(context, listen: false)
                          .user);
                      if (comment != "" && submitted == false) {
                        submitted = true;
                        int userId =
                            Provider.of<AuthsProvider>(context, listen: false)
                                .user!
                                .id!;
                        print(userId);
                        Comment c = Comment(
                          content: comment,
                          postId: post.id,
                          userId: userId,
                        );
                        await Provider.of<ForumProvider>(context, listen: false)
                            .addComment(c);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => SinglePostScreen(
                              post: post,
                            ),
                          ),
                        );
                      }
                    },
                    onChanged: (value) {
                      comment = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Comment',
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      labelStyle: TextStyle(color: Colors.green[900]!),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.green[900]!),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.green[900]!),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // hintText: "Email",
                    ),
                  ),
                ),
              ],
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
