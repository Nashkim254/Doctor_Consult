import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consult/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAppoints extends StatefulWidget {
  @override
  _ViewAppointsState createState() => _ViewAppointsState();
}

class _ViewAppointsState extends State<ViewAppoints> {
  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("appointments/myAppointments");
  String about = null;
  String name = null;
  String time = null;
  StreamSubscription<DocumentSnapshot> subscription;

  void _fetch() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          about = datasnapshot.data()['about'];
          name = datasnapshot.data()['name'];
          time = datasnapshot.data()['time'];
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
          about = datasnapshot.data()['about'];
          name = datasnapshot.data()['name'];
          time = datasnapshot.data()['time'];
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
          title: Text('View AppointMents'),
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
                  child: about == null
                      ? Container()
                      : Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 0.5,
                            child: Text(
                              about,
                              style: GoogleFonts.mcLaren(
                                  fontSize: 18.0, color: kYellowColor),
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: name == null
                      ? Container()
                      : Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 0.5,
                            child: Text(
                              name,
                              style: GoogleFonts.mcLaren(
                                  fontSize: 18.0, color: kYellowColor),
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: time == null
                      ? Container()
                      : Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 0.5,
                            child: Text(
                              time,
                              style: GoogleFonts.mcLaren(
                                  fontSize: 18.0, color: kYellowColor),
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
