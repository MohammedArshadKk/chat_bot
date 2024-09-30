import 'package:chat_bot/controller/chat_bot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatBotController chatBotController = Get.put(ChatBotController());
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat With AI',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: chatBotController.chatHistory.length,
                itemBuilder: (context, index) {
                  final String text = chatBotController.chatHistory[index];
                  String response = text.substring(0, 2);
                  String message =
                      response == 'AI' ? text.substring(3) : text.substring(5);

                  bool isAI = response == 'AI';

                  return Align(
                    alignment: isAI ? Alignment.topLeft : Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isAI
                            ? Colors.grey[300]
                            : Colors.deepPurple[
                                100], // Different colors for AI and user
                        borderRadius: BorderRadius.only(
                          topLeft: isAI ? Radius.zero : Radius.circular(12),
                          topRight: isAI ? Radius.circular(12) : Radius.zero,
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: isAI
                                ? Colors.black
                                : Colors.white, // Text color change
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter your message',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: chatBotController.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : IconButton(
                              onPressed: () {
                                chatBotController
                                    .snedMessage(messageController.text);
                                messageController.clear();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
