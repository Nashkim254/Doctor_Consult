import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consult/components/category_card.dart';
import 'package:doctor_consult/components/doctor_card.dart';
import 'package:doctor_consult/components/search_bar.dart';
import 'package:doctor_consult/constant.dart';
import 'package:doctor_consult/screens/admin_area.dart';
import 'package:doctor_consult/screens/appointments.dart';
import 'package:doctor_consult/screens/faqs.dart';
import 'package:doctor_consult/screens/feedback.dart';
import 'package:doctor_consult/screens/my_account.dart';
import 'package:doctor_consult/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
 final FirebaseAuth auth;
 final FirebaseFirestore firestore;
 HomeScreen({this.auth,this.firestore});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DocumentReference documentReference = FirebaseFirestore.instance.doc("doc/mydoc");
  String name = null;
  String role = null;
  StreamSubscription<DocumentSnapshot> subscription;
  void _fetchDoc(){
    documentReference.get().then((documentsnapshot){
      if(documentsnapshot.exists){
        setState(() {
          name= documentsnapshot.data()['name'];
          role = documentsnapshot.data()['role'];
        });
      }
    }).catchError((e){
      print(e);
    });
  }
  @override
  void initState() {
    super.initState();
    subscription = documentReference.snapshots().listen((documentsnapshot) {
      if(documentsnapshot.exists){
        setState(() {
          name= documentsnapshot.data()['name'];
          role = documentsnapshot.data()['role'];
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
    return Scaffold(
      appBar: new AppBar(
        actions: [
          new IconButton(
            icon: Image.asset('assets/images/profile_icon.png'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyAccount()));
            },
          ),
          IconButton(
            key: const ValueKey("signOut"),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              AuthService().signOut();
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.amber,
                child: const Text('C'),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: const Text('O'),
                )
              ],
              accountEmail: const Text('code@gmail.com'),
              accountName: const Text('code'),
            ),
            ListTile(
              title: const Text(
                'Doctor Consult',
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              trailing: Icon(Icons.arrow_upward),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(),
            ListTile(
              title: const Text('Feedback',
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo)),
              trailing: Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FeedBack()));
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Admin Area',
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
              trailing: Icon(Icons.account_circle),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AdminPage()));
              },
            ),
            Divider(),
            ListTile(
              title: const Text('FAQs',
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange)),
              trailing: new Icon(Icons.assignment),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Faqs()));
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Logout',
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              trailing: new Icon(Icons.person_pin),
              onTap: () {
                AuthService().signOut();
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Book Appointment'),
              trailing: Icon(Icons.border_color),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Appointments()));
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Close',
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: new SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Find Your Desired\nDoctor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: kTitleTextColor,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SearchBar(),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kTitleTextColor,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildCategoryList(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Top Doctors',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kTitleTextColor,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildDoctorList(),
          ],
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          CategoryCard(
            'Diabetes\nconsultant',
            'assets/images/eye_specialist.png',
            kBlueColor,
          ),
          SizedBox(
            width: 20,
          ),
          CategoryCard(
            'Hypertension\nSpecialist',
            'assets/images/heart_surgeon.png',
            kYellowColor,
          ),
        ],
      ),
    );
  }

  buildDoctorList() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
          DoctorCard(
            name == null ? "" : name,
            role == null ? "" : role,
            'assets/images/doctor1.png',
            kBlueColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            name == null ? "": name,
            role == null ? "": role,
            'assets/images/doctor2.png',
            kYellowColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            name == null ? "" : name,
            role == null ? "" : role,
            'assets/images/doctor3.png',
            kOrangeColor,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
