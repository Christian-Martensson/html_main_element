import 'package:MainTextHTML/src/print_tree.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

_hashTree(Element x) {
  final map = <Element, int>{};
  for(final child in x.children) {
    map.addAll(_hashTree(child));
  }
  map[x] = x.hashCode;
  return map;
}

_textTree(Element x) {
  final map = <Element, String>{};
  for(final child in x.children) {
    map.addAll(_textTree(child));
  }
  map[x] = x.text;
  return map;
}

void main() {
  group('Typetests', () {

    const htmlText = '''
    <html>
      <head>
        <title>Very best car story.</title>
      </head>
      <body>
        <h1>The story of my car</h1>
        <div>
          <p>I once <b>had</b> a car.</p>
          <p>I bought it from a car store.</p>
          <p>But then <i>I sold it.</i></p>
          <p>Now I don't have a car.</p>
        </div>
      </body>
    </html>
    ''';

    final document = parse(htmlText);

    setUp(() {
    });

    test('Print hashes', () {
      final hashes = _hashTree(document.documentElement);
      printTree(hashes, document.documentElement);
      final texts = _textTree(document.documentElement);
      printTree(texts, document.documentElement);
    });
  });
}
