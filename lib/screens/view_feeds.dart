import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consult/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewFeeds extends StatefulWidget {
  @override
  _ViewFeedsState createState() => _ViewFeedsState();
}

class _ViewFeedsState extends State<ViewFeeds> {
  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("feedback/myfeedback");
  String title = null;
  String message = null;
  StreamSubscription<DocumentSnapshot> subscription;

  void _fetch() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          title = datasnapshot.data()['title'];
          message = datasnapshot.data()['message'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          title = datasnapshot.data()['about'];
          message = datasnapshot.data()['name'];
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('View Feedback'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _fetch();
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: title == null
                      ? Container()
                      : Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                            elevation: 0.5,
                            child: Text("Type:"+""+
                              title,
                              style: GoogleFonts.mcLaren(
                                fontSize: 20.0,
                                color: kYellowColor,
                              ),
                            ),
                          ),
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: message == null
                      ? Container()
                      : Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                            elevation: 0.5,
                            child: Text("Feedback:"+""+
                              message,
                              style: GoogleFonts.mcLaren(
                                fontSize: 15.0,
                                color: kBlueColor,
                              ),
                            ),
                          ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
