import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consult/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appointments extends StatefulWidget {

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
final DocumentReference documentReference  = FirebaseFirestore.instance.doc("appointments/myAppointments");
  TextEditingController  aboutController = TextEditingController();
  TextEditingController  nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  void _addDoc(){
    Map<String,String> docdata = <String,String>{
      "about": aboutController.text,
      "name": nameController.text,
      "time": timeController.text,
    };
    documentReference.set(docdata).whenComplete((){
      print('appointment added');
    }).catchError((e){
      print(e);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness:Brightness.dark,
        textTheme:GoogleFonts.mcLarenTextTheme(),
      ),
          home: Scaffold(
        appBar: AppBar(
          title: Text('Add Appointment'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          bottom: false,
          child: ListView(
            children: <Widget>[
             
               Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height:20.0),
                      TextFormField(
                          controller: aboutController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'eg Appointment',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: kTitleTextColor.withOpacity(0.7),
                          ),
                        ),
                      SizedBox(height:10.0), TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Doctor\'s Name',
                            hintText: 'Dr. ringding',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: kTitleTextColor.withOpacity(0.7),
                          ),
                        ),
                      
                      SizedBox(height:10.0), TextFormField(
                          controller: timeController,
                          decoration: InputDecoration(
                            labelText: 'Consultation time',
                            hintText: 'time for consultation',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: kTitleTextColor.withOpacity(0.7),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        key: const ValueKey("addButton"),
                        onPressed: () {
                          if(nameController.text != ""){
                            _addDoc();
                          }
                        },
                        color: kOrangeColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
             
            ],
          ),
        ),
      ),
    );
  }
}
