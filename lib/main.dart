import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendly_chat/chat_screen.dart';

void main() => runApp( FriendlyChatApp() );

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400]
);

class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build( BuildContext context ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FriendlyChat',
      home: ChatScreen(),
      theme: defaultTargetPlatform == TargetPlatform.iOS
        ? kIOSTheme
        : kDefaultTheme
    );
  }
}
