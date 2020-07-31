import 'package:flutter/material.dart';
import 'package:contact_list_demo/bloc/contact_bloc.dart';
import 'package:contact_list_demo/model/contact.dart';
import 'package:validators/validators.dart';

class EditContactPage extends StatefulWidget {
  EditContactPage({Key key, this.title, this.id, this.name, this.email}) : super(key: key);
  final String title;
  final int id;
  final String name;
  final String email;

  @override
  EditContactPageState createState() => EditContactPageState();
}

class EditContactPageState extends State<EditContactPage> {
  final ContactBloc contactBloc = ContactBloc();
  var _nameController, _emailController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding:
            const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              backButton(),
              headingText(),
              detailsForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  saveContactButton(),
                  deleteContactButton()
                ],
              ),
            ],
          ),
        ),
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
          "Edit Contact",
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

  Widget saveContactButton(){
    return(
      Container(
        margin: EdgeInsets.only(top:10, right:10),
        alignment: Alignment.topCenter,
        child: FlatButton(
          color: Colors.transparent,
          textColor: Colors.blue,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          splashColor: Color.fromARGB(0, 0, 0, 0),
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            final updatedContact = Contact(
              id: widget.id,
              name: _nameController.value.text,
              email: _emailController.value.text
            );
            final isEmailValid = isEmail(updatedContact.email);
            if (updatedContact.name.isNotEmpty && updatedContact.email.isNotEmpty && isEmailValid) {
              /*
              Update contact object by id
              */
              contactBloc.updateContact(updatedContact);
              Navigator.pop(context);
            }
            else {
              /*
              show an alert message when email or name is 
              empty.
              */
              bool isNameEmpty = updatedContact.name.isEmpty;
              String errorText = isNameEmpty ? 'Name cannot be empty!' : 'Email cannot be empty!';
              if(updatedContact.email.isNotEmpty && !isEmailValid){
                errorText = 'Please enter valid email.';
              }
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text('Error'),
                    content: new Text(errorText),
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
            "Save Contact",
            style: TextStyle(fontSize: 15.0),
          ),
        )
      )
    );
  }

  Widget deleteContactButton(){
    return(
      Container(
        margin: EdgeInsets.only(top:10),
        alignment: Alignment.topCenter,
        child: FlatButton(
          color: Colors.transparent,
          textColor: Colors.blue,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          splashColor: Color.fromARGB(0, 0, 0, 0),
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            if (!widget.id.isNaN) {
              /*
              Delete contact object by id
              */
              contactBloc.deleteContactById(widget.id);
              Navigator.pop(context);
            }
          },
          child: Text(
            "Delete Contact",
            style: TextStyle(fontSize: 15.0),
          ),
        )
      )
    );
  }

  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    contactBloc.dispose();
    super.dispose();
  }
}