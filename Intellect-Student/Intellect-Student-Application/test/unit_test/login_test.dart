import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

void main() {
  test("Login Test", () async {
    var k;
    var url = Uri.parse('http://localhost:8000/api/checkLogin');
    var response = await http.get(url);
    k = jsonDecode(response.body);
    expect(k["data"], true);
  });
}
