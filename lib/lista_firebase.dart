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

class ActualizarUsuario extends StatefulWidget {
  final String idUsuarios;
  final String nombre;
  final String apellidos;

  const ActualizarUsuario(
      {Key key, this.idUsuarios, this.nombre, this.apellidos})
      : super(key: key);

  @override
  _ActualizarUsuarioState createState() => _ActualizarUsuarioState();
}

class _ActualizarUsuarioState extends State<ActualizarUsuario> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextFormField(
              controller: nombre,
              decoration: InputDecoration(
                  helperText: 'Actualizar nombre: ${widget.nombre}'),
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
              decoration: InputDecoration(
                  helperText: 'Actualizar apellido: ${widget.apellidos}'),
              //ingresamos un validador
              validator: (validador) {
                if (validador.isEmpty) {
                  return 'ingresar valor';
                }
                return null;
              },
            ),
            Row(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.clear, color: Colors.red[800]),
                    label: Text('Salir')),
                FlatButton.icon(
                    icon: Icon(
                      Icons.update,
                      color: Colors.green[800],
                    ),
                    label: Text('Actualizar datos'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _datos
                            .collection('taller')
                            .document(widget.idUsuarios)
                            .updateData({
                          'nombre': nombre.text,
                          'apellido': apellido.text
                        }).whenComplete(() {
                          Navigator.of(context).pop();
                          nombre.clear();
                          apellido.clear();
                        });
                      }
                    }),
              ],
            )
          ],
        ));
  }
}

//este widget es para mostrar los datos
class ListaUsuariosFirebase extends StatelessWidget {
  //creamos una instancia de firebase
  final _datos = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _datos.collection('taller').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text('Error en la lectura de datos'),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              //mostramos un Map con los resultados
              return ListView(
                children: snapshot.data.documents.map((DocumentSnapshot doc) {
                  return ListTile(
                    title: Text(doc['nombre']),
                    subtitle: Text(doc['apellido']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 50,
                            child: FlatButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: null
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green[800],
                                )),
                          ),
                          SizedBox(
                            width: 50,
                            child: FlatButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: null
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red[800],
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        });
  }
}

