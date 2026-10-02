/// A strict interface representing a key-value local database.
///
/// Depend on this interface in your repositories or services to allow for
/// easy mocking and testing. Use [ConcreteTijuca] for production
/// and [TijucaInMemoryMock] for unit testing.
abstract interface class AbstractTijuca {
  /// Retrieves and deserializes an item from the database.
  ///
  /// [itemKeyName] is the unique string identifier for the stored item.
  /// [getDeserializedData] is a closure that receives the raw serialized string
  /// and must return the strongly-typed object [T].
  ///
  /// Throws a [NotExistingItemError] if the key is not found in the database.
  T getItem<T>(
    String itemKeyName,
    T Function(String serializedData) getDeserializedData,
  );

  /// Serializes and stores an item in the database.
  ///
  /// [itemKeyName] is the unique string identifier you want to assign to the item.
  /// [getSerializedData] is a closure that must return the raw marshalled string
  /// (e.g., a JSON string) representing your object.
  void setItem<T>(String itemKeyName, String Function() getSerializedData);

  /// Removes an item from the database.
  ///
  /// [itemKeyName] is the unique string identifier for the item to be removed.
  ///
  /// Throws a [NotExistingItemError] if the key does not exist.
  void removeItem(String itemKeyName);
}
