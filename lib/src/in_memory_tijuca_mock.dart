import "package:tijuca/src/abstract_tijuca.dart";
import "package:tijuca/src/not_existing_item_error.dart";

class InMemoryTijucaMock implements AbstractTijuca {
  /// Stores the key-value pairs used by the in-memory database mock.
  final Map<String, String> mapOfItems;

  /// Creates an [InMemoryTijucaMock] with the provided [mapOfItems].
  ///
  /// If [mapOfItems] is not provided, an empty map is used.
  InMemoryTijucaMock([Map<String, String>? mapOfItems])
    : mapOfItems = mapOfItems ?? {};

  @override
  T getItem<T>(
    String itemKeyName,
    T Function(String serializedData) getDeserializedData,
  ) {
    final serializedData = mapOfItems[itemKeyName];

    if (mapOfItems.containsKey(itemKeyName)) {
      return getDeserializedData(serializedData!);
    } else {
      throw NotExistingItemError(itemKeyName);
    }
  }

  @override
  void setItem<T>(String itemKeyName, String Function() getSerializedData) {
    final serializedData = getSerializedData();

    mapOfItems[itemKeyName] = serializedData;
  }

  @override
  void removeItem(String itemKeyName) {
    try {
      mapOfItems.remove(itemKeyName);
    } catch (error) {
      throw NotExistingItemError(itemKeyName);
    }
  }
}
