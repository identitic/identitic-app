import 'package:identitic/models/user.dart';

class Validator {
  static String validateUsername(String value) {
    const String pattern = '^\\w{3,}\$';
    if (value.isEmpty) {
      return 'Ingresá un usuario';
    }
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Ingresá un usuario válido';
    }
    return null;
  }

  static String validateEmail(String value) {
    const String pattern =
        '^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$';
    if (value.isEmpty) {
      return 'Ingresá un correo electrónico';
    }
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Ingresá un correo electrónico válido';
    }
    return null;
  }

  static String validatePassword(String value) {
    const String pattern = '^\\w{1,10}\$';
    if (value.isEmpty) {
      return 'Ingresá una contraseña';
    }
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Ingresá una contraseña válida';
    }
    return null;
  }

  static String validateEditName([User user]) {
    if (user == null) return 'Error';
    if (user.hierarchy == UserHierarchy.student){
      return 'No estas autorizado/a para esta función';
    }
    if (user.hierarchy == UserHierarchy.teacher){
      return 'Consulte con soporte para el uso de esta función';
    }
    return null;
  }
}
