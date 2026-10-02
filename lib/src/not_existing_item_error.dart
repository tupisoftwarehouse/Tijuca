import "package:tijuca/src/constants.dart";

/// An error thrown when a requested item is not found in the database.
///
/// This is typically thrown by [AbstractTijuca.getItem] and
/// [AbstractTijuca.removeItem] when they are called with a [keyName]
/// that does not currently exist in local storage.
class NotExistingItemError extends Error {
  /// The unique string identifier that could not be found.
  String keyName;

  /// Creates a [NotExistingItemError] associated with the missing [keyName].
  NotExistingItemError(this.keyName);

  @override
  String toString() {
    return NOT_EXISTING_ITEM_ERROR_MESSAGE(keyName);
  }
}
