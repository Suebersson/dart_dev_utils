extension FunctionsForString on String{
  
  /// Converter a primera letra para maiúscula
  String get capitalize => this[0].toUpperCase() + this.substring(1);

  /// Converter a primeira letra de todas as palavras para maiúscula
  String get capitalizeAll => this
    .split(' ')
    .asMap().entries
    .map((e) => e.value.capitalize)
    .toList()
    .join(' ');

}
