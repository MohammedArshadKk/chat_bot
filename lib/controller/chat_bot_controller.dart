import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBotController extends GetxController {
  final RxList<String> chatHistory = <String>[].obs;
  RxBool isLoading = false.obs;
  late GenerativeModel generativeModel;

  @override
  void onInit() {
    String? api = dotenv.env['API_KEY'];
    generativeModel =
        GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: api!);
    super.onInit();
  }

  snedMessage(String message) async {
    isLoading.value = true;
    chatHistory.add("user: $message");
    try {
      final response =
          await generativeModel.generateContent([Content.text(message)]);
      chatHistory.add('AI:${response.text}');
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
      isLoading.value = false;
    }
  }
}
