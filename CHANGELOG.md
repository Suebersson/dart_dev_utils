## 1.0.0
* 1º release

## 1.0.1
* 2º release

## 1.0.2
* 3º release

## 1.0.3
* 4º release

## 1.0.4
* Mudanças na classe DataStream, preparando ela para ser a base de uma controller para projetos dart e flutter

## 1.0.5
* Remoção da biblioteca de salvar temporariamente arquivos na memória

## 1.0.6
* Remoção da função 'consolidateByteData'

## 1.0.7
* Implementação de novas expressões regulares e funções

## 1.0.8
* Implementação das classes Disposeble, DartDevUtils; método printLog 

## 1.0.9
* Implementação da função passwordGenerate

## 1.1.0
* Melhorias

## 1.1.1
* Melhorias no objeto DataStream (criar uma instância de uma streamController comum ou broadcast)
* Melhorias na função removeAccents
* Implementação da função convertStringToNumericalBase e suas extensões: String.toBinaryList, String.toOctalList, String.toHexadecimalList, String.toDuotrigesimalList, String.toUniCodeList, String.toHexaBytes, String.toBase64, String.base64ToUTF16String
* Implementação da função Map.getValueFromKey
* Implementação da função List.firstWhereMultComputation

## 1.1.2
* Correção da dependência [meta] para 1.7.0

## 1.1.3
* Substituição de alguns [assert] por [if] para ao invés de gerar um erro, impossibilitar a execução e processamento de uma função

## 1.1.4
* Implementação da expressão regular [regExpGlobalPhone] para válidar números de telefones através do prefixo

## 1.1.5 
* Implementações: [DataStream.periodicWithInitialValue]
* extension: [String > toBytes], [List\<int\> > toBase64]

## 1.1.6
* Atualização dart

## 1.1.7
* Implementação da função [startsOrEndsWith] como uma extension para Strings

## 1.1.8
* Implementação da classe [Email] para tratar strings no formato de endereços de emails

## 1.1.9
* Implementação de construtores factory, das funções [partialObscureText] e                 [partialObscureTextFromRange] dentro do objeto [Email]
* Implementação da função [partialObscureTextForPhone] dentro da mixin [Functions]

## 1.2.0
* Implementação da função [computeWhileNull]

## 1.2.1
* Tornando a função [computeWhileNull] não static

## 1.2.2
* Remoção do objeto [Disposeble]