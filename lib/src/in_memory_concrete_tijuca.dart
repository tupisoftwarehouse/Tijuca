import "package:tijuca/src/in_memory_tijuca_mock.dart";

class ConcreteTijuca extends InMemoryTijucaMock {
  /// The implementation used as the underlying key-value database.
  // ignore: unused_field
  final Object _keyValueDatabaseImplementation;

  /// Creates a [ConcreteTijuca] using the provided key-value database
  /// implementation.
  ConcreteTijuca(this._keyValueDatabaseImplementation);
}
