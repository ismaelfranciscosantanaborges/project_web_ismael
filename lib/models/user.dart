import 'package:formulario_web_t2/models/enums.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String telefono;
  ContactType contactType;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.telefono,
      this.contactType});
}
