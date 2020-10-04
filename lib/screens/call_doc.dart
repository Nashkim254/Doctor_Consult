import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallDoc extends StatefulWidget {
  @override
  _CallDocState createState() => _CallDocState();
}

class _CallDocState extends State<CallDoc> {
  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Call Doctor'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            new MaterialButton(
              color: Colors.blue,
              child: new Text("PICK CONTACT"),
              onPressed: () async {
                Contact contact = await _contactPicker.selectContact();
                setState(() {
                  _contact = contact;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            ),
            new GestureDetector(
              onTap: () {
                String phone = "tel:" + _contact.toString();
                launch(phone);
              },
              child: Text(
                _contact == null ? 'No contact selected.' : _contact.toString(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Emergency call',
                  hintText: 'Enter Emegency no. here:e.g 911',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              controller: textEditingController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            ),
            RaisedButton(
                color: Colors.teal,
                child: Text('Call'),
                onPressed: () {
                  call1();
                }),
          ]),
        ),
      ),
    );
  }

  void call1() {
    String phone = "tel:" + textEditingController.text;
    launch(phone);
  }
}
