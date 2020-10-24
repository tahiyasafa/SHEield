import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  String contactName,  contactType;
  double contactNumber;

  getContactName(name){
    this.contactName = name;
  }

  getContactNumber(number) {
    this.contactNumber = double.parse(number);
  }

  getContactType(type) {
    this.contactType = type;
  }

  createData() {
    print("saved");
    DocumentReference documentReference = Firestore.instance.collection("WomenSafetyContact").
    document(contactName);

    Map<String, dynamic> contact = {
    "contactType": contactType,
      "contactName": contactName,
    "contactNumber": contactNumber
  };
    
    documentReference.setData(contact).whenComplete(() => print("$contact saved"));


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Contact Type",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,
                          width: 2.0),
                    )
                ),
                onChanged: (String type) {
                  getContactType(type);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0),
                  )
                ),
                onChanged: (String name) {
                  getContactName(name);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,
                          width: 2.0),
                    )
                ),
                onChanged: (String number) {
                  getContactNumber(number);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("Save"),
                  textColor: Colors.white,
                  onPressed: () {
                    createData();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
