import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formulario_web_t2/cubit/cubit/register_cubit.dart';
import 'package:formulario_web_t2/models/user.dart';

import 'details_screen.dart';

enum ContactType { laboral, personal, academico }

class AddAndUpdateContactScreen extends StatelessWidget {
  static final String route = 'SignUpScreen';

  User user;
  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    // final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'TERISCO',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'Arial',
          ),
        ),
      ),
      body: Container(
        color: Colors.blue[900],
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Agregando contacto',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              _LForm(
                user: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LForm extends StatefulWidget {
  _LForm({
    Key key,
    @required this.user,
  }) : super(key: key);
  final User user;
  @override
  __LFormState createState() => __LFormState();
}

class __LFormState extends State<_LForm> {
  ContactType _character = ContactType.personal;
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
    _firtsNameController = TextEditingController(text: _user?.firstName ?? '');
    _lastNameController = TextEditingController(text: _user?.firstName ?? '');
    _telefonoController = TextEditingController(text: _user?.firstName ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        // height: _screenSize.height * 0.6,
        child: BlocConsumer<RegisterCubit, RegisterState>(
      builder: (context, bloc) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.only(bottom: 25),
              // height: (_screenSize.height * 0.6) - 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _CTextFormField(
                      controller: _firtsNameController,
                      title: 'Nombre',
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _CTextFormField(
                      controller: _lastNameController,
                      title: 'Apellido',
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _CTextFormField(
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
                    context.bloc<RegisterCubit>().addNewUser(_user);
                  }
                },
                color: Colors.blue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'ENVIAR',
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

class _CTextFormField extends StatelessWidget {
  const _CTextFormField({
    Key key,
    @required this.title,
    @required TextEditingController controller,
    this.textInputType = TextInputType.name,
  })  : _firtsNameController = controller,
        super(key: key);

  final TextEditingController _firtsNameController;
  final String title;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 79,
      alignment: Alignment.topCenter,
      child: TextFormField(
        keyboardType: textInputType ?? TextInputType.name,
        controller: _firtsNameController,
        decoration: InputDecoration(
          labelText: title ?? '',
        ),
        validator: (value) =>
            value.length < 2 ? 'Este campo tiene que pasar de 2 carac.' : null,
      ),
    );
  }
}
