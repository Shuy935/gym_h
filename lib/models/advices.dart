import 'package:cloud_firestore/cloud_firestore.dart';

class AdvicesModel {
  // final String? id;
  // final String text;

  // const AdvicesModel({
  //   this.id,
  //   required this.text,
  // });

  // toJson() {
  //   return {"Texto": text};
  // }

  Future<String?> getAdvice(String id) async {
    try {
      CollectionReference advice =
          FirebaseFirestore.instance.collection('advices');
      final snap = await advice.doc(id).get();
      final data = snap.data() as Map<String, dynamic>;
      return data['text'];
    } catch (e) {
      print(e);
    }
  }
}
