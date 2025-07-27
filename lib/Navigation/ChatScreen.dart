import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String userId;
  final Map<String, dynamic> providerData;

  const ChatScreen(
      {super.key,
      required this.chatId,
      required this.userId,
      required this.providerData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .add({
      'text': text,
      'senderId': widget.userId,
      'timestamp': Timestamp.now(),
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.providerData['fullName'] ?? 'Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    final msg = messages[index];
                    final isMe = msg['senderId'] == widget.userId;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blueAccent : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(msg['text'],
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Type a message"),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
