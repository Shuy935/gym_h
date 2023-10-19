import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String url = "https://owlbot.info/api/v4/dictionary/";
  // String token = "9ff98480522a7e0932b57f8831b405f0cb8fa5d7";

  // TextEditingController textEditingController = TextEditingController();
  // final user = FirebaseAuth.instance.currentUser!;
  // late StreamController streamController;
  // late Stream _stream;

  // searchText() async {
  //   if (textEditingController.text == null ||
  //       textEditingController.text.length == 0) {
  //     streamController.add(null);
  //     return;
  //   }
  //   streamController.add("waiting");
  //   Uri uri = Uri.parse(url + textEditingController.text.trim());
  //   Response response =
  //       await get(uri, headers: {"Authorization": "Token " + token});
  //   streamController.add(json.decode(response.body));
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   streamController = StreamController();
  //   _stream = streamController.stream;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.orange.shade300,
            Colors.orange.shade100,
            Colors.white
          ]),
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            minimumSize: Size.fromHeight(50),
          ),
          icon: Icon(Icons.arrow_back, size: 32),
          label: Text(
            'Sign Out',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: FirebaseAuth.instance.signOut,
        ),
      ),
    );
  }
}
