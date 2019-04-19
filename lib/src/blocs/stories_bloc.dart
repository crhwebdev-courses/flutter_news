import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();

  // Getters to get Streams
  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    //fetch ids from repository
    final ids = await _repository.fetchTopIds();

    //add ids to _topIds sink so that they are available to other
    // components
    _topIds.sink.add(ids);
  }

  //destructor
  dispose() {
    _topIds.close();
  }
}
