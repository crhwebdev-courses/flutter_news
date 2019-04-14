import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  fetchItem(int id) async {
    //check for item in db and return it if it exists
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }

    //get item from api if it is not cached in database
    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);

    return item;
  }
}
