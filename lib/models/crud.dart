import 'package:cloud_firestore/cloud_firestore.dart';
import 'response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collectionReference =
    _firestore.collection('advices');

class Crud {
  // Create
  static Future<Response> addEmployee({
    required String text,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collectionReference.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "text": text,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  // Read
  static Stream<QuerySnapshot> readAdvices() {
    CollectionReference advicesRead = _collectionReference;
    return advicesRead.snapshots();
  }

  // Update
  static Future<Response> updateEmployee({
    required String text,
    required String id,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collectionReference.doc(id);

    Map<String, dynamic> data = <String, dynamic>{
      "text": text,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  // Delete
  static Future<Response> deleteEmployee({
    required String id,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collectionReference.doc(id);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
