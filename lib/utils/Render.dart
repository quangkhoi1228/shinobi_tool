import 'package:html_unescape/html_unescape.dart';

class Render {
  static dynamic htmlUnescape(String input, {isObject = false}) {
    var unescape = HtmlUnescape();
    return unescape.convert(input);
  }
}
