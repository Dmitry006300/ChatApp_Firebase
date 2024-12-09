import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mini_chat_app/models/message.dart';

class ChatService {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
   final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return firebase.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

 Future<void> sendMessage (String receiverID, message) async {
    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderID: currentUserID, 
      senderEmail: currentUserEmail, 
      receiverID: receiverID, 
      message: message, 
      timestamp: timestamp,
      );

      List<String> ids = [currentUserID, receiverID];
      ids.sort();
      String chatRoomID = ids.join('_');

      await firebase.collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .add(newMessage
      .toMap());
  }

Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
List<String> ids = [userID, otherUserID];
ids.sort();
String chatRoomID = ids.join('_');

return firebase.collection("chat_rooms")
.doc(chatRoomID)
.collection("messages")
.orderBy("timestamp", descending: false)
.snapshots();
}

}
