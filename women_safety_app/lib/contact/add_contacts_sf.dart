import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  TextEditingController _nameController, _numberController;
  String _typeSelected = '';

  DatabaseReference _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Contacts');
  }

  Widget _buildContactType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title
              ? Colors.red
              : Color(0xFF303B90),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Segoe UI'),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF010115),
        title: Text('Save Contact'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg2.png"),
            fit: BoxFit.cover,
          ),
        ),
        //margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                child: Image.asset("images/logo.png"),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "Segoe UI"),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      borderSide: BorderSide(color: Colors.red)
                      //borderSide: const BorderSide(),
                      ),
                  //fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintText: 'Enter Number',
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "Segoe UI"),
                  prefixIcon: Icon(
                    Icons.phone_iphone,
                    size: 30,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      borderSide: BorderSide(color: Colors.red)
                      //borderSide: const BorderSide(),
                      ),
                  //fillColor: Colors.white,
                  filled: true,

                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                //color: Colors.red,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildContactType('Work'),
                    SizedBox(width: 10),
                    _buildContactType('Family'),
                    SizedBox(width: 10),
                    _buildContactType('Friends'),
                    SizedBox(width: 10),
                    _buildContactType('Others'),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                //padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 45.0,
                  child: RaisedButton(

                      color: Color(0xFFE22C3C),


                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(32.0),
                        side: BorderSide(color: Colors.red),

                      ),

                      child: Text(
                        'Save Contact',
                        style: TextStyle(color: Colors.white,fontFamily: 'Segoe UI',fontSize: 15.0),
                      ),
                      onPressed: () async {
                        saveContact();
                      }
                  ),
                ),
              ),
              SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveContact() {
    String name = _nameController.text;
    String number = _numberController.text;

    Map<String, String> contact = {
      'name': name,
      'number': '+880 ' + number,
      'type': _typeSelected,
    };

    _ref.push().set(contact).then((value) {
      Navigator.pop(context);
    });
  }
}
