import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000/'));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data); // Output: {message: Welcome to Flask Backend!}
  } else {
    print('Failed to load data');
  }
}
