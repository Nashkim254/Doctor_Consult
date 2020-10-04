import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consult/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
final DocumentReference documentReference  = FirebaseFirestore.instance.doc("doc/mydoc");
  TextEditingController  aboutController = TextEditingController();
  TextEditingController  nameController = TextEditingController();
  TextEditingController  roleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  void _addDoc(){
    Map<String,String> docdata = <String,String>{
      "about": aboutController.text,
      "name": nameController.text,
      "role": roleController.text,
      "time": timeController.text,
    };
    documentReference.set(docdata).whenComplete((){
      print('doctor added');
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
          title: Text('Add Doctor'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: Container(
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
                            labelText: 'About',
                            hintText: 'Enter about here',
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
                            labelText: 'Name',
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
                      SizedBox(height:10.0),
                      TextFormField(
                          controller: roleController,
                          decoration: InputDecoration(
                            labelText: 'Role',
                            hintText: 'Hypertension/diabetes',
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
                            labelText: 'Time',
                            hintText: 'Availbale time',
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
                          'Add Doctor',
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
