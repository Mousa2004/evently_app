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
    CollectionReference eventCollection = getEventCollection();
    DocumentReference doc = eventCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }
}
