/*
 
Debe realizar una aplicación web utilizando Javascript(Js), esta app debe 
contener un formulario para que las personas puedan colocar la información 
de sus contacto (Nombre ,Apellido , Teléfono y si es un contacto laboral, 
personal o académico), los datos de Nombre , apellido y teléfonos son 
requeridos asi que deben ser validados usando javascript.

Al dar click sobre al botón de enviar del formulario debe validarse los 
datos mencionados anteriormente si todo es valido, se debe agregar la 
información a una tabla, si algún dato es invalido se debe decir cual 
dato es invalido en este caso que no tiene información.

Los contactos agregado a las tablas deben poder editar y eliminarse.

Para realizar esta aplicación tendrán que utilizar Html, Boostrap (Css si con 
bootstrap no lo es suficiente para algún ajuste) , Javascript, 
Dhtml(Manejo del dom)

**/
import 'package:flutter/material.dart';
import 'package:formulario_web_t2/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: SignUpScreen.route,
      routes: {SignUpScreen.route: (context) => SignUpScreen()},
    );
  }
}
