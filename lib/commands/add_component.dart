import 'dart:io';

/// Converts a camelCase or PascalCase name to snake_case
String toSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
    return '${match.group(1)}_${match.group(2)}';
  }).toLowerCase();
}

void main(List<String> args) {
  if (args.isEmpty) {
    print("❌ Error: Please provide a page name.");
    print("Usage: dart generate_page.dart HomePage");
    return;
  }

  final String pageName = args[0]; // e.g., ForgetPassword
  final String snakeCaseName = toSnakeCase(pageName); // e.g., forget_password
  final String modelName = '${pageName}Model'; // e.g., ForgetPasswordModel

  final String folderPath = 'lib/components/$snakeCaseName';
  final String pageFilePath = '$folderPath/${snakeCaseName}.dart';
  final String modelFilePath = '$folderPath/${snakeCaseName}_model.dart';

  // Ensure the folder exists
  Directory(folderPath).createSync(recursive: true);

  // Widget Class
  final String widgetClass = '''
import '../../structure_main_flow/flutter_mada_theme.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '${snakeCaseName}_model.dart';

class $pageName extends StatefulWidget {
  const $pageName({super.key});

  @override
  State<$pageName> createState() => _${pageName}WidgetState();
}

class _${pageName}WidgetState extends State<$pageName>
    with TickerProviderStateMixin {
  late $modelName _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => $modelName());
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterMadaTheme.of(context).info,
          body: SafeArea(
              top: true,
              child: Container()),
        ));
  }
}
''';

  // Model Class
  final String modelClass = '''
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import '${snakeCaseName}.dart' show $pageName;

class $modelName extends FlutterMadaModel<$pageName> {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
''';

  // Create the files
  File(pageFilePath).writeAsStringSync(widgetClass);
  File(modelFilePath).writeAsStringSync(modelClass);

  print("✅ Created: $pageFilePath");
  print("✅ Created: $modelFilePath");
}
