import 'package:flutter/material.dart';

void openTaskDetails(BuildContext context, String routeName,
    {dynamic arg}) async {
  Navigator.of(context).pushNamed(routeName, arguments: arg);
}

// void openAddUser(BuildContext context) async {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => AddUserScreen(),
//     ),
//   );
// }