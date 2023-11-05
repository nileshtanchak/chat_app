import 'dart:convert';

import 'package:first_project_in_mac/http_handler/http_handler.dart';
import 'package:first_project_in_mac/model/auth_models/registration_model.dart';
import 'package:first_project_in_mac/model/chat/all_user_list_model.dart';
import 'package:first_project_in_mac/utils/api_url.dart';
import 'package:first_project_in_mac/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController extends GetxController {
  RxBool loader = false.obs;
  Rx<AllUserListModel> userListModel = Rx<AllUserListModel>(AllUserListModel());
  Rx<List<Users>?> userList = Rx<List<Users>?>([]);
  TextEditingController chatController = TextEditingController();
  IO.Socket? socket;
  Rx<List<ChatMessage>> chatMessages = Rx<List<ChatMessage>>([]);

  Future<void> getUserList() async {
    loader.value = true;

    ResponseModel response = await HttpHandler.getApiCall(url: ApiUrl.allUser);

    if (response.error == "null") {
      kPrint("userListModel : ${jsonDecode(response.data ?? "")}");

      userListModel.value =
          AllUserListModel.fromJson(jsonDecode(response.data ?? ""));
      kPrint("userListModel : ${userListModel.value}");
      userList.value = userListModel.value.users ?? [];
      kPrint("userList : ${userList.value}");
    }
    loader.value = false;
  }

  initSocket() {
    socket = IO.io(ApiUrl.baseUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket?.connect();
    socket?.onConnect((_) {
      kPrint('Connection established');
    });

    socket?.on('message', (data) {
      kPrint('Received message: $data');
      // Handle the received message here
    });

    socket?.onDisconnect((_) => kPrint('Connection Disconnection'));
    socket?.onConnectError((err) => kPrint(err));
    socket?.onError((err) => kPrint(err));
  }

  void sendMessageToServer(String roomId, String message, Users user) {
    socket?.emit(
        'sendMessage', {'roomId': roomId, 'message': message, 'user': user});
  }

  void onSendMessagePressed(String messageText1, String id, Users user) {
    String messageText = chatController.text.trim(); // G

    String roomId = "123$id";
    sendMessageToServer(
        roomId, messageText1, user); // Send the message to the server.
    print("user instance:: ${user.id}");
    print("user instance:: ${user.name}");
    // Update the UI to display the sent message.
    ChatMessage sentMessage = ChatMessage(text: messageText, sender: user);

    chatMessages.update((value) {
      value?.add(sentMessage);
    });

    kPrint("chat list:: ${chatMessages.value[0].text}");

    chatController.clear();
  }

  void joinChatRoom({required String roomId, required String username}) {
    socket?.emit('joinRoom', {'roomId': roomId, 'username': username});
  }

  void getChatHistory() {
    loader.value = true;
    // Emit an event to request chat history from the server

    socket?.on('chatHistory', (chatHistory) {
      kPrint("chat history chatHistory:: $chatHistory");

      List<ChatMessage> historyMessages = (chatHistory as List).map((message) {
        kPrint("Sender data:: ${message['sender']}");
        return ChatMessage(
          text: message['message'] ?? "",
          sender: message['sender'] ?? Users(),
        );
      }).toList();

      // Update your chatMessages list with the chat history
      chatMessages.value = historyMessages;

      kPrint("chat history data:: $historyMessages");
      kPrint("chat history data:: ${chatMessages.value}");
    });

    socket?.emit('requestChatHistory');
    loader.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getUserList();
    initSocket();

    // Request chat history when the screen is loaded
    getChatHistory();
  }
}

class ChatMessage {
  final String text;
  final Users
      sender; // Assuming User is another class representing a chat user.

  ChatMessage({
    required this.text,
    required this.sender,
  });
}
