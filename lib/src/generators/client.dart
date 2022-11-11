import 'dart:io';

import '../classes/collection.dart';
import '../utils/file.dart';
import 'base.dart';
import 'collection.dart';
import '../utils/format.dart';

const _template = r'''import 'package:firestore_sqlite/firestore_sqlite.dart';

{{#collections}}
import "collections/{{name}}.dart";
{{/collections}}

{{#collections}}
export "collections/{{name}}.dart";
{{/collections}}

class Client extends FirestoreClient {
   @override
   List<Collection> get collections => [
   {{#collections}}
      {{#camel_case}}{{name}}{{/camel_case}}Collection,
   {{/collections}}
   ];

   {{#collections}}
   /// {{description}}
   late final {{#camel_case}}{{name}}{{/camel_case}} = FirestoreClientCollection(this, {{#camel_case}}{{name}}{{/camel_case}}Collection);
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
