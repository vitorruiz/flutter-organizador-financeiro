mixin FormValidator {
  String? combineValidations(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }

  String? isNotEmpty(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? "Esse campo é obrigatório";
    }
    return null;
  }

  String? isValidDecimal(String? value, [String? message]) {
    if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
      return message ?? "Valor inválido";
    }
    return null;
  }
}
