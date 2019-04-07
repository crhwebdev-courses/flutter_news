import 'package:http/http.dart' show Client;
import 'dart:convert';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client
        .get('https://hacker-news.firebaseio.com/v0/topstories.json');
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem() {}
}
