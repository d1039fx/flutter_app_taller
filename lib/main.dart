import 'package:flutter/material.dart';
import 'package:flutter_app_taller/provider.dart';
import 'package:provider/provider.dart';

import 'lista.dart';
import 'lista_firebase.dart';
import 'notas.dart';
import 'notas_provider.dart';

void main() => runApp(MaterialDesign());

//sin implementacion de material design
class PrimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
          'https://flutter-es.io/images/flutter-logo-sharing.png'),
    );
  }
}

//con implementacion de material design
class MaterialDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //agregamos el provider en el root de la aplicacion asi podra ser usado en toda la estructura de archivos del app
    return ChangeNotifierProvider(
      builder: (context) => CalculoNotas(),
      child: MaterialApp(
        home: WidgetPrincipalEstructura2(),
      ),
    );
  }
}

//se crea un widget principal
class WidgetPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //incluimos un appbar
      appBar: AppBar(
        title: Text('Primera app'),
      ),
      //incluimos una imagen centrada
      body: Center(
        child: Image.network(
            'https://flutter-es.io/images/flutter-logo-sharing.png'),
      ),
    );
  }
}

//creamos un widget principal con una columna para incluir mas elementos
class WidgetPrincipalEstructura extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estructura basica'),
      ),
      //usamos column para mostrar mas elementos
      body: Column(
        children: <Widget>[
          Center(
            child: Image.network(
                'https://flutter-es.io/images/flutter-logo-sharing.png'),
          ),
          //ingresamos un contenedor incluyendo en el un texto
          Container(
            child: Text('Actividades'),
          )
        ],
      ),
    );
  }
}

//creamos un widget para mostrar los botones de calculo de notas y listas
class WidgetPrincipalEstructura2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estructura basica'),
      ),
      //usamos column para mostrar mas elementos
      body: Column(
        //definimos un espacio entre los widgets
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Image.network(
                'https://flutter-es.io/images/flutter-logo-sharing.png'),
          ),
          //ingresamos un contenedor incluyendo en el un texto
          Container(
            child: Text('Actividades'),
          ),
          //incluimos una fila para los botones
          Row(
            //definimos un espacio entre los botones
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                //abrimos el archivo que permite el calculo de notas
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Notas())),
                child: Text('Notas'),
              ),
              //abrimos el archivo que permite mostrar la lista
              RaisedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Lista())),
                child: Text('Lista'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotasProvider())),
                child: Text('Notas provider'),
              ),
              RaisedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListaFirebase())),
                child: Text('Lista Firebase'),
              )
            ],
          )
        ],
      ),
    );
  }
}

//creamos un archivo llamado notas.dart para mostrar la pagina que hace el calculo de las notas
