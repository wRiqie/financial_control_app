import 'package:financial_control_app/app/core/values/languages/en_us.dart';
import 'package:financial_control_app/app/core/values/languages/pt_br.dart';
import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUs,
    'pt_BR': ptBr,
  };

}