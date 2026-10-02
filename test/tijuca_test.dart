import "package:flutter_test/flutter_test.dart";
import "package:tijuca/src/abstract_tijuca.dart";
import "package:tijuca/src/internals/test_mocks/item_value_object.dart";
import "package:tijuca/src/constants.dart";
import "package:tijuca/src/not_existing_item_error.dart";
import "package:tijuca/src/in_memory_tijuca_mock.dart";

void main() {
  group("Test \"Tijuca\" Class", () {
    late AbstractTijuca instance;

    setUp(() {
      instance = InMemoryTijucaMock();
    });

    test("Test If Method \"getItem\" Returns Item Data", () {
      (instance as InMemoryTijucaMock).mapOfItems[ITEM_KEY] =
          ITEM.marshalledData;

      final item = instance.getItem(ITEM_KEY, (marshalledData) {
        return ItemValueObject.fromMarshalledData(marshalledData);
      });

      expect(item.data, ITEM_DATA);
    });

    test("Test If Method \"getItem\" Throws \"NotExistingItemError\" If Item Does Not Exist", () {
      try {
        instance.getItem(ITEM_KEY, (_) {});
      } catch (error) {
        expect(error, isA<NotExistingItemError>());
      }
    });

    test("Test If Method \"setItem\" Stores Item Data", () {
      instance.setItem(ITEM_KEY, () {
        return ITEM.marshalledData;
      });

      expect(
        (instance as InMemoryTijucaMock).mapOfItems[ITEM_KEY],
        ITEM.marshalledData,
      );
    });

    test("Test If Method \"removeItem\" Removes Item Data", () {
      (instance as InMemoryTijucaMock).mapOfItems[ITEM_KEY] =
          ITEM.marshalledData;

      instance.removeItem(ITEM_KEY);
    });

    test("Test If Method \"removeItem\" Throws \"NotExistingItemError\" If Item Does Not Exist", () {
      try {
        instance.removeItem(ITEM_KEY);
      } catch (error) {
        expect(error, isA<NotExistingItemError>());
      }
    });
  });
}
