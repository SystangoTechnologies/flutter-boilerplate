import 'package:flutter/material.dart';
import 'package:contact_list_demo/bloc/contact_bloc.dart';
import 'package:contact_list_demo/ui/edit_contact_page.dart';
import 'package:contact_list_demo/model/contact.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ViewContactPage extends StatefulWidget {
  ViewContactPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ViewContactPageState createState() => ViewContactPageState();
}

class ViewContactPageState extends State<ViewContactPage> {
  final ContactBloc contactBloc = ContactBloc();
  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: LoadingOverlay(
        opacity: 0.0,
        isLoading: showLoader,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding:
              const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                backButton(),
                headingText(),
                Expanded(
                  child: getContactsWidget()
                )
              ]
            )
          )
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
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5
          ),
          child: Text(
            "Contacts",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black
            ),
          ), 
        )
      )
    );
  }

  Widget getContactsWidget() {
    /*
    The StreamBuilder widget,
    basically this widget will take stream of data (contacts)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: contactBloc.contacts,
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
        return getContactCardWidget(snapshot);
      },
    );
  }


  Widget getContactCardWidget(AsyncSnapshot<List<Contact>> snapshot) {
    /*
    Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator
    */
    if (snapshot.hasData) {
      /*
      Also handles whenever there's stream
      but returned 0 records of Contact from DB.
      If that the case show user that you have empty Contacts
      */
      snapshot.data.sort((a, b) => a.name.compareTo(b.name));
      return snapshot.data.length != 0
        ? ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, itemPosition) {
              Contact contact = snapshot.data[itemPosition];
              final Widget contactCard = new Container (
                height: 50,
                child: contactItem(contactId: contact.id, contactName: contact.name, contactEmail: contact.email, contactExtensions: contact.extensions)
              );
              return contactCard;
            },
          )
        : Container(
            child: Center(
            // this is used whenever there 0 Contact
            // in the data base
            child: noContactMessageWidget(),
          ));
    } else {
      return Center(
        /*
        since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the user know the app is currently
        processing
        */
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    // pull contacts again
    contactBloc.getContacts();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w500
              )
            )
          ],
        ),
      ),
    );
  }

  Widget noContactMessageWidget() {
    return Container(
      child: Text(
        "No contacts",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget contactItem({int contactId, String contactName, String contactEmail, Map<String, dynamic> contactExtensions}){
    return (
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black45,
              width: 0.5
            )
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditContactPage(
                    id: contactId,
                    name: contactName,
                    email: contactEmail,
                    extensions: contactExtensions
                  )
                ),
              ).then((refetch) async{
                if(refetch) {
                  setState(() {
                    showLoader = true;
                  });
                  await contactBloc.getContacts();
                  setState(() {
                    showLoader = false;
                  });
                }
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  contactName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black
                  ),
                ), 
                Text(
                  contactEmail,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black
                  ),
                ),
              ]
            )
          )
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
