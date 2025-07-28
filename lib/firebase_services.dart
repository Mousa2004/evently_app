import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event_model.dart';

class FirebaseServices {
  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance
          .collection("Events")
          .withConverter(
            fromFirestore: (snapshot, _) =>
                EventModel.fromjson(snapshot.data()!),
            toFirestore: (event, _) => event.tojson(),
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
}
