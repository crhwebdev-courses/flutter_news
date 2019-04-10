import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test_api/test_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () {
    final newsApi = NewsApiProvider();

    //create a mock client that returns some fake list of ids
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
  });
}
