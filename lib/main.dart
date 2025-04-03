
import 'package:http/http.dart' as http;

void main() async {
  const String baseUrl = "https://week-8-practice-3484f-default-rtdb.asia-southeast1.firebasedatabase.app";

  const String students = "students";
  const String allLOcations = '$baseUrl/$students.json';

  Uri uri = Uri.parse(allLOcations);
  final http.Response response = await http.get(uri);

}

