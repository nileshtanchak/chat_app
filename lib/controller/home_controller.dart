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
      print('Connection established');
    });

    socket?.on('message', (data) {
      print('Received message: $data');
      // Handle the received message here
    });

    // Set up the event handler for 'chatHistory'
    socket?.on('chatHistory', (chatHistory) {
      List<ChatMessage> historyMessages = (chatHistory as List).map((message) {
        return ChatMessage(
          text: message['message'],
          sender: message['sender'],
        );
      }).toList();

      // Update your chatMessages list with the chat history
      chatMessages.value = historyMessages;
    });

    socket?.onDisconnect((_) => print('Connection Disconnection'));
    socket?.onConnectError((err) => print(err));
    socket?.onError((err) => print(err));
  }

  sendMessageToServer(String messageText, String id) {
    socket?.emit('sendMessage', {'roomId': "123$id", 'message': messageText});
  }

  void onSendMessagePressed(String messageText1, String id, Users user) {
    String messageText = chatController.text
        .trim(); // Get the message text from the input field or widget.
    sendMessageToServer(messageText1, id); // Send the message to the server.

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
    // Emit an event to request chat history from the server
    socket?.emit('requestChatHistory');
  }

  @override
  void onInit() {
    // TODO: implement onInit
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
