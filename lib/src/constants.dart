import "package:tijuca/src/internals/test_mocks/item_value_object.dart";

String NOT_EXISTING_ITEM_ERROR_MESSAGE(String keyName) {
  return "Item with key \"$keyName\" does not exist.";
}

const ITEM_KEY = "";

const ITEM_DATA_FIELD = "data";

const ITEM_DATA = "Lorem ipsum dolor sit amet.";

const ITEM = ItemValueObject(ITEM_DATA);
