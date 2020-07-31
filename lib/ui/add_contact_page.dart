import 'package:flutter/material.dart';
import 'package:contact_list_demo/bloc/contact_bloc.dart';
import 'package:contact_list_demo/model/contact.dart';

class AddContactPage extends StatefulWidget {
  AddContactPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  AddContactPageState createState() => AddContactPageState();
}

class AddContactPageState extends State<AddContactPage> {
  final ContactBloc contactBloc = ContactBloc();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding:
            const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
          child: Column(
            children: [
              backButton(),
              headingText(),
              detailsForm(),
              addContactButton()
            ]
          )
        )
      ),
    );
  }

  Widget backButton(){
    return(
      Container(
        alignment: Alignment.topLeft,
          child: FlatButton(
            color: Colors.transparent,
            textColor: Colors.blue,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Color.fromARGB(0, 0, 0, 0),
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Back",
              style: TextStyle(fontSize: 16.0),
            ),
        )
      )
    );
  }

  Widget headingText(){
    return(
      Container(
        alignment: Alignment.center,
        child: SizedBox(
          height: 50.0,
          child: Text(
            "Add New Contact",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black
            ),
          ),
        )
      )
    );
  }
  Widget detailsForm() {
    return(
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0
        ),
        child: Column(
          children: [
            nameContainer(),
            emailContainer()
          ]
        ) 
      )
    );
  }

  Widget nameContainer () {
    return (
      SizedBox(
        height: 30,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: SizedBox(
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0
                  ),
                  child: Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black
                    ),
                  ),
                )
              ),
            ),
            Flexible(
              flex: 2,
              child: Form(
                child: TextFormField(
                  controller: _nameController,
                  style: TextStyle (
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                    hintText: 'Enter Name',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              )
            )
          ]
        )
      )
    );
  }

  Widget emailContainer () {
    return (
      Padding(
        padding: const EdgeInsets.only(
          top: 15.0
        ),
        child: SizedBox(
          height: 30,
          width: double.maxFinite,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: SizedBox(
                  width: 130,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0
                    ),
                    child: Text(
                      "Email Address",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black
                      ),
                    ),
                  )
                ),
              ),
              Flexible(
                flex: 2,
                child: Form(
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle (
                      color: Colors.black
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1.0),
                      ),
                      hintText: 'Enter Email',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }
                  ),
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget addContactButton(){
    return(
      Container(
        alignment: Alignment.topCenter,
        child: FlatButton(
          color: Colors.transparent,
          textColor: Colors.blue,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          splashColor: Color.fromARGB(0, 0, 0, 0),
          padding: EdgeInsets.only(
            top: 20.0
          ),
          onPressed: () {
            final newContact = Contact(
              name: _nameController.value.text,
              email: _emailController.value.text
            );
            if (newContact.name.isNotEmpty && newContact.email.isNotEmpty) {
              /*
              Create new Contact object and make sure
              the Contact name and email is not empty
              */
              contactBloc.addContact(newContact);
              Navigator.pop(context);
            } else {
              /*
              show an alert message when email or name is 
              empty.
              */
              bool isNameEmpty = newContact.name.isEmpty;
              String errorText = isNameEmpty ? 'Name' : 'Email';
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text('Error'),
                    content: new Text(errorText + " cannot be empty!"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text(
            "Add Contact",
            style: TextStyle(fontSize: 16.0),
          ),
        )
      )
    );
  }
}