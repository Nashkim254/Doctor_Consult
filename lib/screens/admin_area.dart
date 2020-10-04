import 'package:doctor_consult/constant.dart';
import 'package:doctor_consult/screens/add_doctor.dart';
import 'package:doctor_consult/screens/appointments.dart';
import 'package:doctor_consult/screens/view_appoints.dart';
import 'package:doctor_consult/screens/view_feeds.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            Card(
              margin: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OnboardingScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.group_add,
                        size: 70.0,
                        color: Colors.green,
                      ),
                      Text(
                        'Add Doctor',
                        style: GoogleFonts.mcLaren(
                          fontSize: 17.0,
                          color: kYellowColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top:18.0,bottom: 14.0,left: 18.0,right: 18.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ViewAppoints()));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.library_books,
                        size: 70.0,
                        color: Colors.deepOrange,
                      ),
                      Text(
                        'View\nAppointments',
                        style: GoogleFonts.mcLaren(
                          fontSize: 14.0,
                          color: kYellowColor
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ViewFeeds()));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.feedback,
                        size: 70.0,
                        color: Colors.lightBlueAccent,
                      ),
                      Text(
                        'Feedback',
                        style: GoogleFonts.mcLaren(
                          fontSize: 17.0,
                          color: kYellowColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
