class Contact {
  int id;
  String name;
  String email;
  Map<String, dynamic> extensions;

  // When using curly braces { } we note dart that
  // the parameters are optional
  Contact({this.id, this.name, this.email, this.extensions});
}
