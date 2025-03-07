import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mini_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade400)
            : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
              ? Colors.white
              : (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
