import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance
          .collection("Events")
          .withConverter(
            fromFirestore: (snapshot, _) =>
                EventModel.fromjson(snapshot.data()!),
            toFirestore: (event, _) => event.tojson(),
          );

  static CollectionReference<UserModel> getusersCollection() =>
      FirebaseFirestore.instance
          .collection("Users")
          .withConverter(
            fromFirestore: (snapshot, _) =>
                UserModel.fromjson(snapshot.data()!),
            toFirestore: (users, _) => users.tojson(),
          );

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference doc = eventCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    QuerySnapshot<EventModel> querySnapshot = await eventCollection
        .orderBy('datatime')
        .get();
    return querySnapshot.docs.map((query) => query.data()).toList();
  }

  static Future<void> editEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventCollection.doc(event.id);
    return doc.update(event.tojson());
  }

  static Future<void> deleteEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventCollection.doc(event.id);
    return doc.delete();
  }

  //Authentication

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credenttial = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserModel user = UserModel(
      id: credenttial.user!.uid,
      name: name,
      email: email,
      favouritesEventsIds: [],
    );
    CollectionReference<UserModel> userCollection = getusersCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> userCollection = getusersCollection();
    DocumentSnapshot<UserModel> docSnapshot = await userCollection
        .doc(credential.user!.uid)
        .get();
    return docSnapshot.data()!;
  }

  static Future<void> addEventToFavourites(String eventId) async {
    CollectionReference<UserModel> userCollection = getusersCollection();
    DocumentReference<UserModel> doc = userCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return doc.update({
      //Add item to the existing items in list we use ** FieldValue.arrayUnion([]) **.
      'favouritesEventsIds': FieldValue.arrayUnion([eventId]),
    });
  }

  static Future<void> deleteEventToFavourites(String eventId) async {
    CollectionReference<UserModel> userCollection = getusersCollection();
    DocumentReference<UserModel> doc = userCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return doc.update({
      //Remove item to the existing items in list we use ** FieldValue.arrayRemove([]) **.
      'favouritesEventsIds': FieldValue.arrayRemove([eventId]),
    });
  }
}
