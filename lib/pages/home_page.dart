import 'package:flutter/material.dart';
import 'package:flutter_mini_chat_app/pages/chat_page.dart';
import 'package:flutter_mini_chat_app/services/auth/auth_service.dart';
import 'package:flutter_mini_chat_app/services/chat/chat_service.dart';
import 'package:flutter_mini_chat_app/widget_components/my_drawer.dart';
import 'package:flutter_mini_chat_app/widget_components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const MyDrawer(),
      body: builedUserList(),
    );
  }

  Widget builedUserList() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>(
                (userData) => buildUserListItem(userData, context),
              )
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
            ),
          ),
        );
      },
    );
  }
}
