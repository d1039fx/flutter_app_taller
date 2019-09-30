import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuarios'),
      ),
      body: Column(
        children: <Widget>[
          IngresoUsuarios(),
          
        ],
      ),
    );
  }
}

//creamos dos widgets uno para guardar datos y otro para mostrarlos

//este widget es para ingresar datos
class IngresoUsuarios extends StatefulWidget {
  @override
  _IngresoUsuariosState createState() => _IngresoUsuariosState();
}

class _IngresoUsuariosState extends State<IngresoUsuarios> {
  //creamos una llave global para el estado del formulario y un controlador para el ingreso de datos
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombre = TextEditingController();
  final TextEditingController apellido = TextEditingController();
  //creamos una instancia de firestores
  Firestore _datos = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nombre,
              decoration: InputDecoration(helperText: 'Ingresar Nombre'),
              //ingresamos un validador
              validator: (validador) {
                if (validador.isEmpty) {
                  return 'ingresar valor';
                }
                return null;
              },
            ),
            TextFormField(
              controller: apellido,
              decoration: InputDecoration(helperText: 'Ingresar Apellido'),
              //ingresamos un validador
              validator: (validador) {
                if (validador.isEmpty) {
                  return 'ingresar valor';
                }
                return null;
              },
            ),
            Center(
              child: RaisedButton(
                  child: Text('Guardar datos'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _datos.collection('taller').add({
                        'nombre': nombre.text,
                        'apellido': apellido.text
                      }).whenComplete(() {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Se guardaron los datos correctamente')));
                        nombre.clear();
                        apellido.clear();
                      });
                    }
                  }),
            )
          ],
        ));
  }
}



