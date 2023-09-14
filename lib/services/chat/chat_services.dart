import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:h_chat/models/message.dart';

class ChatService extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SEND MESSAGE
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user Id
    final String userCurrentId = _auth.currentUser!.uid;
    final String userCurrentEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create a new message

    Message newMessage = Message(
        senderId: userCurrentId,
        senderEmail: userCurrentEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    //
    List<String> ids = [userCurrentId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    //
    await _firestore
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("message")
        .add(newMessage.toMap());
  }

  //GET MESSSAGE
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("message")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
