import "package:flutter_test/flutter_test.dart";
import "package:tijuca/src/abstract_tijuca.dart";
import "package:tijuca/src/internals/test_mocks/item_value_object.dart";
import "package:tijuca/src/constants.dart";
import "package:tijuca/src/not_existing_item_error.dart";
import "package:tijuca/src/in_memory_tijuca_mock.dart";

void main() {
  group("Tijuca", () {
    late AbstractTijuca instance;

    setUp(() {
      instance = InMemoryTijucaMock();
    });

    group("getItem", () {
      test("should return item data", () {
        (instance as InMemoryTijucaMock).mapOfItems[ITEM_KEY] =
            ITEM.marshalledData;

        final item = instance.getItem(ITEM_KEY, (marshalledData) {
          return ItemValueObject.fromMarshalledData(marshalledData);
        });

        expect(item.data, ITEM_DATA);
      });

      test("should throw when item does not exist", () {
        try {
          instance.getItem(ITEM_KEY, (_) {});
        } catch (error) {
          expect(error, isA<NotExistingItemError>());
        }
      });
    });

    group("setItem", () {
      test("should store item data", () {
        instance.setItem(ITEM_KEY, () {
          return ITEM.marshalledData;
        });

        expect(
          (instance as InMemoryTijucaMock).mapOfItems[ITEM_KEY],
          ITEM.marshalledData,
        );
      });
    });

    group("removeItem", () {
      test("should remove item data", () {
        (instance as InMemoryTijucaMock).mapOfItems[ITEM_KEY] =
            ITEM.marshalledData;

        instance.removeItem(ITEM_KEY);
      });

      test("should throw when item does not exist", () {
        try {
          instance.removeItem(ITEM_KEY);
        } catch (error) {
          expect(error, isA<NotExistingItemError>());
        }
      });
    });
  });
}
