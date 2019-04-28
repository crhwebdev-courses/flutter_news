import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();

  //Rx stream
  final _topIds = PublishSubject<List<int>>();

  //Rx stream controller
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  final _itemsFetcher = PublishSubject<int>();

  // Getters to get Streams
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  //construtor that initializes _items.stream.transform with _itemsTransformer
  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    //fetch ids from repository
    final ids = await _repository.fetchTopIds();

    //add ids to _topIds sink so that they are available to other
    // components
    _topIds.sink.add(ids);
  }

  Future<int> clearCache() {
    return _repository.clearCache();
  }

  //helper method that returns a cache map with ItemModels
  //for each id given to it
  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  //destructor
  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
