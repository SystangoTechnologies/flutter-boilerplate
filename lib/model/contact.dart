class Contact {
  int id;
  String name;
  String email;

  // When using curly braces { } we note dart that
  // the parameters are optional
  Contact({this.id, this.name, this.email});
  
  /*
  Factory method will be used to convert JSON objects that
  are coming from querying the database and converting
  it into a Contact object
  */
  factory Contact.fromDatabaseJson(Map<String, dynamic> data) => Contact(
    id: data['id'],
    name: data['name'],
    email: data['email']
  );

  /*
  This method will be used to convert Contact objects that
  are to be stored into the datbase in a form of JSON
  */
  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "name": this.name,
    "email": this.email
  };
}
