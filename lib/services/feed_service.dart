// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctor_consult/models/feed_model.dart';

// class Database {


//   // final FirebaseFirestore firestore;

//   // Database({this.firestore});

//   // Stream<List<FeedModel>> streamFeeds({String uid}) {
//   //   try {
//   //     return firestore
//   //         .collection("feedback")
//   //         .doc(uid)
//   //         .collection("feedback")
//   //         .snapshots()
//   //         .map((query) {
//   //      final List<FeedModel> retVal = <FeedModel>[];
//   //       for (final DocumentSnapshot doc in query.docs) {
//   //         retVal.add(FeedModel.fromDocumentSnapshot(documentSnapshot: doc));
//   //       }
//   //       return retVal;
//   //     });
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
  
//   // Future<void> addFeed({String uid, String title, String message}) async {
//   //   try {
//   //     firestore.collection("feedback").doc(uid).collection("feedback").add({
//   //       "title": title,
//   //       "message": message,
//   //     });
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
  
//   //   Future<void> updateFeed({String uid, String feedId}) async {
//   //   try {
//   //     firestore
//   //         .collection("feedback")
//   //         .doc(uid)
//   //         .collection("feedback")
//   //         .doc(feedId)
//   //         .update({
//   //     });
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
    
//   }