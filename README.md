## Funções utilitárias para desenvolvimento dart e flutter



```dart
import 'package:dart_dev_utils/dart_dev_utils.dart';

void main() async{
  
  // Formato: 000.000.000-00
  print(dartDevUtils.regExpCPF.hasMatch('000.000.000-00')); // true
  
  // Formatos: 00900000000; (00)900000000; 0090000-0000; (00)90000-0000
  print(dartDevUtils.regExpCellPhoneBR.hasMatch('(00)900000000')); // true

  // Formatos: 0000000000; (00)00000000; 000000-0000; (00)0000-0000
  print(dartDevUtils.regExpFixePhoneBR.hasMatch('(00)30000000')); // true

  print('suebersson montalvão'.capitalize); // Suebersson montalvão

  print('suebersson montalvão'.capitalizeAll); // Suebersson Montalvão

  print('Suebérssôn montalvão'.removeAccents); // Suebersson montalvao

}
```

