import 'package:flutter/material.dart';
import 'package:formulario_web_t2/models/user.dart';
import 'package:formulario_web_t2/widgets/widgets.dart';

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
                user == null ? 'Agregando contacto' : 'Modificando contacto',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              CForm(
                user: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
