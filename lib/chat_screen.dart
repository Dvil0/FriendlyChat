import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendly_chat/chat_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text( 'FriendlyChat'),
            elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0
        ),
        body: Container(
          child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.all( 8.0 ),
                    reverse: true,
                    itemBuilder: ( _, int index ) => _messages[index],
                    itemCount: _messages.length
                  )
                ),
                Divider( height: 1.0 ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor
                  ),
                  child: _buildTextComposer()
                ),
              ]
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
              border: Border(
                top: BorderSide( color: Colors.grey[200] )
              )
            )
            : null
        )
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 8.0 ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _isComposing ? _handleSubmitted : null,
              decoration: InputDecoration.collapsed(
                  hintText: 'Send a message'
              ),
              focusNode: _focusNode,
              onChanged: ( String text ) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              }
            )
          ),
          IconTheme(
            data: IconThemeData( color: Theme.of(context).accentColor ),
            child: Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Theme.of(context).platform == TargetPlatform.iOS ?
                CupertinoButton(
                    child: Text( 'Send' ),
                    onPressed: _isComposing
                        ? () => _handleSubmitted( _textController.text )
                        : null
                ) :
                IconButton(
                    icon: const Icon( Icons.send ),
                    onPressed: _isComposing
                        ? () => _handleSubmitted( _textController.text )
                        : null
                )
            ),
          )
        ]
      )
    );
  }

  void _handleSubmitted( String text ) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration( milliseconds: 400 ),
        vsync: this
      )
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  @override
  void dispose() {
    for( ChatMessage message in _messages )
      message.animationController.dispose();
    super.dispose();
  }
}