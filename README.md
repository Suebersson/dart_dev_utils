## Funções utilitárias para desenvolvimento dart e flutter



```dart
import 'package:dart_dev_utils/dart_dev_utils.dart';

void main() async{
  
  // Formato: 000.000.000-00
  print(Constants.i.regExpCPF.hasMatch('077.744.914-57'));
  
  // Formatos: 00900000000; (00)900000000; 0090000-0000; (00)90000-0000
  print(Constants.i.regExpCellPhoneBR.hasMatch('(21)985854628')); // true

  // Formatos: 0000000000; (00)00000000; 000000-0000; (00)0000-0000
  print(Constants.i.regExpFixePhoneBR.hasMatch('(21)85854628')); // true

  print('suebersson montalvão'.capitalize); // Suebersson montalvão

  print('suebersson montalvão'.capitalizeAll); // Suebersson Montalvão

  var f = Functions.i.checkFileExist(filePath: 'C:/Users/name/AppData/Local/Temp/cachedFilesFlutterApp/Google-flutter-logo.png');
  print('Exist: $f');

  await Functions.i.getByteDataFromInternet(url: 'https://getlogo.net/wp-content/uploads/2020/08/flutter-logo-vector.png').then((uint8List) {
    Functions.i.createFile(filePath: 'C:/Users/name/...png', bytesData: uint8List).then((value) {
      print('---- Arquivo creado com sucesso ----');
    });
  });

  await Functions.i.getByteDataFromFile(filePath: 'C:/Users/name/...png').then((value) {
    print(value);
  });

}
```
