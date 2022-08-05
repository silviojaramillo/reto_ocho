import 'dart:io';
import 'dart:math';

void main(List<String> args) {
  /*###############################################################
  #                  OCTAVO RETO DE PROGRAMACIÓN                  #
  #                                                               #
  #     Solicitar all usuario tres números enteros y con          #
  #     ellos calcular su mínimo común múltiplo                   #
  #     Nota: realizar el proceso con la descomposición en        #
  #     en factores primos                                        #
  ###############################################################*/

  /*****************************************************************
  Creando la lista para almacenar los números a los que se les va
  a sacar el Mínimo Cómun Múltiplo.
  ******************************************************************/
  List values = [];
  /*****************************************************************
   Solicitando al usuario loa cantidad de números para calcular el MCM
   y los valores correspondientes de cada número.
   *****************************************************************/
  print('Ingrese la cantidad de números de los cuales desee hallar el MCM: ');
  String? readOne = stdin.readLineSync();
  int first = int.parse(readOne.toString());
  print('Ingrese los $first números para realizar el cálculo del MCM: ');
  for (var i = 0; i < first; i++) {
    String? readTwo = stdin.readLineSync();
    int second = int.parse(readTwo.toString());
    values.add(second);
  }
  /*****************************************************************
  Creando el mapa para almacenar los valores de cada divisor y el 
  número de veces que se repite cada uno.
  ******************************************************************/
  Map<int, int> factors = {2: 0};
  /*****************************************************************
  Creando el arreglo para guardar los divisores comunes.
  ******************************************************************/
  //Creando las variables de control para realizar el cálculo
  int numberFactor = 2;
  bool conditional = true;
  int repeatFactor = 1;
  num MCM = 1;
  /*****************************************************************
  Creando la función para calcular los divisores y realizar el
  registro de ellos en el mapa de acuerdo a la cantidad de veces que
  se repite y teniendo en cuenta que la cantidad a guardar en caso 
  de repetición será la mayor mayor.
  Ej: divisores de 10 = 2*5, en este caso el mapa quedaría así:
  factors = {2:1,5:1}; divisores de 20 = 2*2*5
  por tanto se debe guardar factors = {2:2,5:1} y este será el
  mapa con sus valores finales y que nos interesan.
  ******************************************************************/
  calculateMCM(number) {
    while (conditional) {
      double quotient = number / numberFactor;
      if (number % numberFactor != 0) {
        numberFactor++;
        repeatFactor = 1;
      } else {
        if (factors[numberFactor] == null ||
            factors[numberFactor]! <= repeatFactor) {
          factors[numberFactor] = repeatFactor;
          repeatFactor++;
        } else if (factors[numberFactor]! > repeatFactor) {
          repeatFactor++;
        }
        number = quotient;
      }
      if (quotient == 1) {
        numberFactor = 2;
        repeatFactor = 1;
        conditional = false;
      }
    }
  }

  for (var i = 0; i < values.length; i++) {
    calculateMCM(values[i]);
    //Debemos volver la condicional a verdadero para que el while
    //se evalúe ya que habíamos dejado en false para que se finalice
    //y poder repetir el proceso con el siguiente número.
    conditional = true;
  }

  //Realizando la operación con los valores del Mapa para conocer
  //el valor del MCM.
  factors.forEach((key, value) {
    MCM = MCM * pow(key, value);
  });
  /*****************************************************************
  Ahora vamos a calcular el MCD (Máximo Común Divisor).
  ******************************************************************/

  print('El Mínimo Común Múltiplo de los número ingresados es: $MCM');
}
