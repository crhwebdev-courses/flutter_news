import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();

  //Rx stream
  final _topIds = PublishSubject<List<int>>();

  //Rx stream controller
  final _items = BehaviorSubject<int>();

  // Getters to get Streams
  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    //fetch ids from repository
    final ids = await _repository.fetchTopIds();

    //add ids to _topIds sink so that they are available to other
    // components
    _topIds.sink.add(ids);
  }

  //helper method that returns a cache map with ItemModels
  //for each id given to it
  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  //destructor
  dispose() {
    _topIds.close();
  }
}
