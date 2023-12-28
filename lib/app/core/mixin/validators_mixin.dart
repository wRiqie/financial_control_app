mixin ValidatorsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if ((value ?? '').isEmpty) {
      return message ?? 'O campo não pode ser vazio';
    }
    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (var validator in validators) {
      final result = validator();
      if (result != null) return result;
    }
    return null;
  }
}
