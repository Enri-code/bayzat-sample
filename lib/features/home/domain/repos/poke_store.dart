import 'dart:async';

abstract class Store<T> {
  ///Returns a list of all the keys in the store
  FutureOr<List> get getKeys;

  ///Returns all the elements in the store
  Future<List<T>> getAll();
  Future add(T pokemon);
  Future remove(T pokemon);
}
