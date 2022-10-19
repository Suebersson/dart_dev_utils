import 'package:dart_dev_utils/dart_dev_utils.dart';

void main() {
  
  // Formato: 000.000.000-00
  print(Constants.i.regExpCPF.hasMatch('000.000.000-00')); // true
  
  // Formatos: 00900000000; (00)900000000; 0090000-0000; (00)90000-0000
  print(Constants.i.regExpCellPhoneBR.hasMatch('(00)900000000')); // true

  // Formatos: 0000000000; (00)00000000; 000000-0000; (00)0000-0000
  print(Constants.i.regExpFixePhoneBR.hasMatch('(00)30000000')); // true

  print('suebersson montalvão'.capitalize); // Suebersson montalvão

  print('suebersson montalvão'.capitalizeAll); // Suebersson Montalvão

  print('Suebérssôn montalvão'.removeAccents); // Suebersson montalvao

}
