import 'package:flutter/material.dart';

enum ContactType { laboral, personal, academico }

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);
  static final String route = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ContactType _character = ContactType.personal;
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Formulario'),
      // ),
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
              Text('Bienvenido a Teris club'),
              Text('Bienvenido a Teris club'),
              Container(
                height: _screenSize.height * 0.6,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.all(25),
                      height: (_screenSize.height * 0.6) - 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nombre',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Apellido',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'telefono',
                              ),
                            ),
                            ListTile(
                              title: const Text('Lafayette'),
                              leading: Radio(
                                value: ContactType.laboral,
                                groupValue: _character,
                                onChanged: (ContactType value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: RaisedButton(
                        onPressed: () {},
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
                                letterSpacing: 1.4),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
