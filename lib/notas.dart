//importamos la libreria de material design
import 'package:flutter/material.dart';

//creamos un widget estatico para los elementos que no cambian
class Notas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
      ),
      body: FormIngresoNotas(),
    );
  }
}

//usando un Form
class FormIngresoNotas extends StatefulWidget {
  @override
  _FormIngresoNotasState createState() => _FormIngresoNotasState();
}

class _FormIngresoNotasState extends State<FormIngresoNotas> {
  //definimos los controladores que nos permitiran obtener los valores
  TextEditingController textEditingControllerExamen = TextEditingController();
  TextEditingController textEditingControllerTrabajos = TextEditingController();
  TextEditingController textEditingControllerQuiz = TextEditingController();
  //creamos una llave global que identifica el widget form para validar los datos
  final _textForm = GlobalKey<FormState>();
  //definimos la variable que va a cambiar el estado cuando se ejecute la funcion del calculo de notas
  double resultadoNota;

  //definimos la funcion que hace el calculo de la nota
  void resultadoNotas() {
    //usamos la funcion que nos permite cambiar el estado de la variable y a su vez el widget
    setState(() {
      resultadoNota =
          (double.parse(textEditingControllerExamen.value.text) * 0.5) +
              (double.parse(textEditingControllerTrabajos.value.text) * 0.3) +
              (double.parse(textEditingControllerQuiz.value.text) * 0.2);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //definimos el estdo inicial de la variable cuando se construye el widget
    resultadoNota = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _textForm,
        child: Column(
          children: <Widget>[
            //nota examen
            TextFormField(
              controller: textEditingControllerExamen,
              decoration: InputDecoration(helperText: 'Nota de examen'),
              validator: (validador) {
                if (validador.isEmpty) {
                  return 'campo vacio';
                } else if (double.parse(validador) > 5) {
                  return 'la nota no debe ser mayor que 5';
                } else if (double.parse(validador) < 0) {
                  return 'la nota no debe ser menor que 0';
                }
                return null;
              },
            ),
            //nota de trabajos
            TextFormField(
              controller: textEditingControllerTrabajos,
              decoration: InputDecoration(helperText: 'Nota de trabajos'),
              validator: (validador) {
                if (validador.isEmpty) {
                  return 'campo vacio';
                } else if (double.parse(validador) > 5) {
                  return 'la nota no debe ser mayor que 5';
                } else if (double.parse(validador) < 0) {
                  return 'la nota no debe ser menor que 0';
                }
                return null;
              },
            ),
            //nota de quiz
            TextFormField(
              controller: textEditingControllerQuiz,
              decoration: InputDecoration(helperText: 'Nota de quiz'),
              validator: (validador) {
                if (validador.isEmpty) {
                  return 'campo vacio';
                } else if (double.parse(validador) > 5) {
                  return 'la nota no debe ser mayor que 5';
                } else if (double.parse(validador) < 0) {
                  return 'la nota no debe ser menor que 0';
                }
                return null;
              },
            ),
            Container(
              child: Text('Nota final estudiante: ${resultadoNota.toString()}'),
            ),
            Center(
              child: RaisedButton(
                  child: Text('Calcular nota'),
                  onPressed: () {
                    if (_textForm.currentState.validate()) {
                      resultadoNotas();
                    }
                  }),
            )
          ],
        ));
  }
}
