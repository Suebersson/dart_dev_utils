import 'dart:io' show HttpClient, Directory, Platform;

class Constants{

  static Constants? _instance;

  Constants._();

  static Constants get i {
    _instance ??= Constants._();
    return _instance!;
  }

  final HttpClient httpClient = HttpClient();

  Directory get appDirectory => Directory.systemTemp.parent; 

  Directory get temporaryDirectory => Directory.systemTemp;
  
  Directory get cacheDirectory => 
    Directory('${temporaryDirectory.path}${pathSeparator}cachedFilesFlutterApp');

  String get pathSeparator => Platform.pathSeparator;
  String get localeName => Platform.localeName;
  String get version => Platform.version;
  int get numberOfProcessors => Platform.numberOfProcessors;
  String get getOperatingSystem => Platform.operatingSystem;
  String get getOperatingSystemVersion => Platform.operatingSystemVersion;
  Map<String, String> get getEnvironment => Platform.environment;
  String get getScriptPath => Platform.script.path;
  String get getResolvedExecutable => Platform.resolvedExecutable;

  /*var getEnvironment = Constants.getEnvironment;
  if(getEnvironment.keys.contains('HOMEPATH')){
    print(getEnvironment['HOMEPATH']);
    print(getEnvironment['HOMEDRIVE']);
    print(getEnvironment['COMPUTERNAME']);
    print(getEnvironment['USERNAME']);
    print(getEnvironment['USERPROFILE']);
    print(getEnvironment['COMSPEC']);
    print(getEnvironment['TEMP']);
    print(false);
  }*/
  
  /// expressão regular para válida url
  RegExp get regExpUrls => RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  /// expressão regular para válida e-mails
  RegExp get regExpEmails => RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
  /// expressão regular para válida datas nos formato americanos
  RegExp get regExpDateUS => RegExp(r"^\d{4}-\d{2}-\d{2}");// yyyy-mm-dd
  /// expressão regular para válida datas nos formato brasileiro
  RegExp get regExpDateBR => RegExp(r"^\d{2}-\d{2}-\d{4}");// dd-mm-yyyy
  RegExp get regExpCPF => RegExp(r"^\d{3}.\d{3}.\d{3}-\d{2}");// 000.000.000-00
  /// expressão regular para válida número de telefone celular brasileiro 
  /// Formatos: 00900000000; (00)900000000; 0090000-0000; (00)90000-0000
  RegExp get regExpCellPhoneBR => RegExp(r"((\d{2}9\d{8})|(\(\d{2}\)\9\d{8})|(\d{2}9\d{4}-\d{4})|(\(\d{2}\)\9\d{4}-\d{4}))");
  /// expressão regular para válida número de telefone fixo brasileiro 
  /// Formatos: 0000000000; (00)00000000; 000000-0000; (00)0000-0000
  RegExp get regExpFixePhoneBR => RegExp(r"((\d{10})|(\(\d{2}\)\d{8})|(\d{2}\d{4}-\d{4})|(\(\d{2}\)\d{4}-\d{4}))");
  
}
