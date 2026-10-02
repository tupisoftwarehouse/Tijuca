import "package:tijuca/src/abstract_tijuca.dart";
import "package:tijuca/src/not_existing_item_error.dart";
import "package:mmkv/mmkv.dart";

class ConcreteTijuca implements AbstractTijuca {
  /// The implementation used as the underlying key-value database.
  final MMKV _keyValueDatabaseImplementation;

  /// Creates a [ConcreteTijuca] using the provided key-value database
  /// implementation.
  ConcreteTijuca(this._keyValueDatabaseImplementation);

  @override
  T getItem<T>(
    String itemKeyName,
    T Function(String serializedData) getDeserializedData,
  ) {
    final serializedData = _keyValueDatabaseImplementation.decodeString(
      itemKeyName,
    );

    if (_keyValueDatabaseImplementation.containsKey(itemKeyName)) {
      return getDeserializedData(serializedData!);
    } else {
      throw NotExistingItemError(itemKeyName);
    }
  }

  @override
  void setItem<T>(String itemKeyName, String Function() getSerializedData) {
    final serializedData = getSerializedData();

    _keyValueDatabaseImplementation.encodeString(itemKeyName, serializedData);
  }

  @override
  void removeItem(String itemKeyName) {
    if (_keyValueDatabaseImplementation.containsKey(itemKeyName)) {
      _keyValueDatabaseImplementation.removeValue(itemKeyName);
    } else {
      throw NotExistingItemError(itemKeyName);
    }
  }
}
