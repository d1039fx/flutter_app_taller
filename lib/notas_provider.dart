//importamos la libreria de material design
import 'package:flutter/material.dart';
import 'package:flutter_app_taller/provider.dart';
import 'package:provider/provider.dart';

//creamos un widget estatico para los elementos que no cambian
class NotasProvider extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    //creamos una instancia del provider que nos permitira trabajar con la clase creada para hacer el calculo

    CalculoNotas calculoNotas = Provider.of<CalculoNotas>(context);

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
                } else {
                  calculoNotas.examenValor = double.parse(validador);
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
                } else {
                  calculoNotas.trabajoValor = double.parse(validador);
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
                } else {
                  calculoNotas.quizValor = double.parse(validador);
                }
                return null;
              },
            ),
            Container(
              child: Text(
                  'Nota final estudiante: ${calculoNotas.resultadoValor.toString()}'),
            ),
            Center(
              child: RaisedButton(
                  child: Text('Calcular nota'),
                  onPressed: () {
                    if (_textForm.currentState.validate()) {
                      calculoNotas.resultadoNotas();
                    }
                  }),
            )
          ],
        ));
  }
}
