import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formulario_web_t2/cubit/cubit/register_cubit.dart';
import 'package:formulario_web_t2/models/enums.dart';
import 'package:formulario_web_t2/models/user.dart';
import 'package:formulario_web_t2/widgets/widgets.dart';

class CForm extends StatefulWidget {
  CForm({
    Key key,
    @required this.user,
  }) : super(key: key);
  final User user;
  @override
  _CFormState createState() => _CFormState();
}

class _CFormState extends State<CForm> {
  ContactType _character;
  GlobalKey<FormState> _formKey;
  User _user;
  TextEditingController _firtsNameController;
  TextEditingController _lastNameController;
  TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _user = widget.user != null ? widget.user : User();
    _character = _user.contactType ?? ContactType.personal;
    _firtsNameController = TextEditingController(text: _user?.firstName ?? '');
    _lastNameController = TextEditingController(text: _user?.lastName ?? '');
    _telefonoController = TextEditingController(text: _user?.telefono ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        child: BlocConsumer<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: Responsive.isMobile(context) ? double.infinity : 800,
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CTextFormField(
                      controller: _firtsNameController,
                      title: 'Nombre',
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CTextFormField(
                      controller: _lastNameController,
                      title: 'Apellido',
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CTextFormField(
                      controller: _telefonoController,
                      title: 'Telefono',
                      textInputType: TextInputType.phone,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Personal'),
                      leading: Radio(
                        value: ContactType.personal,
                        groupValue: _character,
                        onChanged: (ContactType value) {
                          _character = value;
                          setState(() {});
                        },
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Laboral'),
                      leading: Radio(
                        value: ContactType.laboral,
                        groupValue: _character,
                        onChanged: (ContactType value) {
                          _character = value;
                          setState(() {});
                        },
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Academico'),
                      leading: Radio(
                        value: ContactType.academico,
                        groupValue: _character,
                        onChanged: (ContactType value) {
                          _character = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _user.firstName = _firtsNameController?.text;
                    _user.lastName = _lastNameController?.text;
                    _user.telefono = _telefonoController?.text;
                    _user.contactType = _character;
                    if (widget.user != null) {
                      context.bloc<RegisterCubit>().updateUser(_user);
                    } else {
                      context.bloc<RegisterCubit>().addNewUser(_user);
                    }
                  }
                },
                color: Colors.blue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    widget.user != null ? 'ACTUALIZAR' : 'AGREGAR',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pop(context);
        }
      },
    ));
  }
}
