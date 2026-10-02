import "dart:convert";

import "package:tijuca/src/constants.dart";

class ItemValueObject {
  final String data;

  const ItemValueObject(this.data);

  factory ItemValueObject.fromMarshalledData(String marshalledData) {
    final unmarshalledData = jsonDecode(marshalledData);

    return ItemValueObject(unmarshalledData[ITEM_DATA_FIELD]);
  }

  String get marshalledData {
    final marshallableData = {ITEM_DATA_FIELD: data};

    return jsonEncode(marshallableData);
  }
}
