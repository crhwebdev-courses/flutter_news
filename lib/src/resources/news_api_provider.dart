import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');

    final item = ItemModel.fromJson(json.decode(response.body));

    return item;
  }
}
