import 'package:flutter/material.dart';

//creamos una clase que nos permitira hacer el calculo de notas y le agregamos las capacidades de change notifier
class CalculoNotas with ChangeNotifier {
  //definimos las variable para el resultado, el ingreso de valores y las inicializamos
  double _resultado = 0.0;
  double _examen = 0.0;
  double _trabajos = 0.0;
  double _quiz = 0.0;

  //obtenemos la variable y hacemos el calculo
  set examenValor(double valor) {
    _examen = valor;
  }

  set trabajoValor(double valor) {
    _trabajos = valor;
  }

  set quizValor(double valor) {
    _quiz = valor;
  }

  //creamos la funcion que nos permite hacer el calculo
  void resultadoNotas() {
    _resultado = (_examen * 0.5) + (_trabajos * 0.3) + (_quiz * 0.2);

    //usamos notifyListeners() para notificar a los widgets del cambio en la variable _resultado
    notifyListeners();
  }

  double get resultadoValor => _resultado;
}
