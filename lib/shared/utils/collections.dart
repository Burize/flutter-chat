// there is no implements for generic ...
List<T> uniqueById<T extends dynamic>(List<T> items) {
  final uniqueItems = Map.fromIterable(items, key: (item) => item.id, value: (item) => item);

  return uniqueItems.values.toList().cast<T>();
}
