import 'dart:io';

import '../classes/collection.dart';
import 'base.dart';
import 'collection.dart';
import 'utils/format.dart';

const _template = r'''import 'package:firestore_sqlite/firestore_sqlite.dart';

{{#collections}}
import "collections/{{name}}.dart";
{{/collections}}

class Client extends FirestoreClient {
   {{#collections}}
   // {{name}} - {{description}}
   Collection get {{#camel_case}}{{name}}{{/camel_case}} => {{#camel_case}}{{name}}{{/camel_case}}Collection;
   Future<List<Doc>> get{{#pascal_case}}{{name}}{{/pascal_case}}s() => getDocs({{#camel_case}}{{name}}{{/camel_case}});
   Stream<List<Doc>> watch{{#pascal_case}}{{name}}{{/pascal_case}}s() => watchDocs({{#camel_case}}{{name}}{{/camel_case}});
   Future<Doc?> get{{#pascal_case}}{{name}}{{/pascal_case}}(String id) => getDoc({{#camel_case}}{{name}}{{/camel_case}}, id);
   Stream<Doc?> watch{{#pascal_case}}{{name}}{{/pascal_case}}(String id) => watchDoc({{#camel_case}}{{name}}{{/camel_case}}, id);
   {{/collections}}
}

''';

class ClientGenerator extends GeneratorBase {
  ClientGenerator({required this.output, required this.collections});
  final List<Collection> collections;
  final Directory output;

  @override
  String get template => _template;

  @override
  Map<String, Object?> get args => {
        'collections': collections.map((e) => e.toJson()).toList(),
      };

  @override
  String render() {
    final result = super.render();
    final formatted = formatDart(result);
    for (final collection in collections) {
      final gen = CollectionGenerator(collection);
      final file = File('${output.path}/collections/${collection.name}.dart')
        ..check();
      file.writeAsStringSync(gen.render());
    }
    final outFile = File('${output.path}/client.dart')..check();
    outFile.writeAsStringSync(formatted);
    return result;
  }
}

extension on File {
  void check() {
    if (!existsSync()) createSync(recursive: true);
  }
}
