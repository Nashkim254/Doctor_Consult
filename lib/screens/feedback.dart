import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc('feedback/myfeedback');
  TextEditingController titleController = TextEditingController();
  TextEditingController feedController = TextEditingController();
  String titlee;
  String feedback;

  void _addFeed() {
    Map<String, String> feed = <String, String>{
      "title": titleController.text,
      "message": feedController.text,
    };
    documentReference.set(feed).whenComplete(() {
      print('document added');
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Feedback'),
          centerTitle: true,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
                child: TextFormField(
                  style: GoogleFonts.mcLaren(),
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      titlee = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextFormField(
                  maxLines: 5,
                  style: GoogleFonts.mcLaren(),
                  controller: feedController,
                  decoration: InputDecoration(
                    labelText: 'Feedback',
                    hintText: 'Feedback here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      feedback = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  onPressed: () {
                    if (titleController.text != "") {
                      _addFeed();
                    }
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Feedback submitted!'),
                      ),
                    );
                  },
                  child: Text(
                    'Submit',
                    textScaleFactor: 1.5,
                  ),
                  splashColor: Theme.of(context).accentColor,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
