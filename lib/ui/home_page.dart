import 'package:flutter/material.dart';
import 'package:contact_list_demo/ui/add_contact_page.dart';
import 'package:contact_list_demo/ui/view_contact_page.dart';
import 'package:contact_list_demo/utils/guid_utils.dart';
import 'package:contact_list_demo/constants/strings.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setGUID();
  }

  setGUID() async {
    // Fetch guid from shared preference.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String guid = prefs.getString(GUID);

    // If guid is not present in the shared preference then 
    // create a new one and store it.
    if(guid == null)
    {
      var uuid = Uuid();
      String guid = uuid.v4();
      await prefs.setString(GUID, guid);
    }
    GUIDUtils guidUtils = new GUIDUtils();
    guidUtils.setGuid(guid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding:
            const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0, top: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              newContactButton(),
              viewContactButton(),
            ]
          )
        )
      ),
    );
  }

  Widget newContactButton(){
    return(
      Container(
        alignment: Alignment.topCenter,
        child: FlatButton(
          color: Colors.transparent,
          textColor: Colors.blue,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          splashColor: Color.fromARGB(0, 0, 0, 0),
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContactPage()),
            );
          },
          child: Text(
            "Add New Contact",
            style: TextStyle(fontSize: 16.0),
          ),
        )
      )
    );
  }

  Widget viewContactButton(){
    return(
      Container(
        alignment: Alignment.topCenter,
        child: FlatButton(
          color: Colors.transparent,
          textColor: Colors.blue,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          splashColor: Color.fromARGB(0, 0, 0, 0),
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewContactPage()),
            );
          },
          child: Text(
          "View Contacts",
            style: TextStyle(fontSize: 16.0),
          ),
        )
      )
    );
  }
}
