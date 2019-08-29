//importamos la libreria de material design
import 'package:flutter/material.dart';

//definimos el widget principal que puede ser inmutable
class Lista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de items'),
      ),
      body: ListaItems(),
    );
  }
}

class ListaItems extends StatefulWidget {
  @override
  _ListaItemsState createState() => _ListaItemsState();
}

class _ListaItemsState extends State<ListaItems> {
  //creamos un array con informacion de la lista
  final List<String> titulo = <String>['item 1', 'item 2', 'item 3'];
  final List<String> descripcion = <String>[
    'descripcion del item 1',
    'descripcion del item 2',
    'descripcion del item 3'
  ];
  final List<String> imagenItem = <String>[
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSasWfm-yUh-rWBWxoPYS9_WalNv1n3-kWAizzZCMXw66YsKRZP',
    'https://cdn2.iconfinder.com/data/icons/black-animal-svg-icons/512/monkey_face_animal_ape_donkey-512.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX8BckgNd_M3JDVXsH0i1GAj_YwpoL1Gcqt8kP0aWvmxNEzWoz1w'
  ];

  @override
  Widget build(BuildContext context) {
    //usamos un widget para mostrar listas
    return ListView.builder(
        //defimos la longitud de la lista
        itemCount: titulo.length,
        itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(titulo[index]),
                subtitle: Text(descripcion[index]),
                leading: Image.network(imagenItem[index]),
              ),
            ));
  }
}
