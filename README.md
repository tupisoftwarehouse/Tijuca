![](./thumbnail.png)

<h1 align="center">Tijuca: A fast, abstract, and highly testable key-value local database wrapper for Dart and Flutter.</h1>

<br/>
<br/>

<div align="center">
  <a href="#description">✍️ Description</a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a href="#installation">⬇️ Installation</a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a href="#getting_started">🚀 Getting Started</a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a href="#testing">🧪 Testing</a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a href="#contact">✉️ Contact</a>
</div>

<br />
<br />

<h3 id="description">✍️ Description:</h3>

<p>Backed by the blazing-fast <a href="https://pub.dev/packages/mmkv">MMKV</a> package, <code>tijuca</code> provides a strict interface for storing, retrieving, and removing serialized objects while abstracting away the underlying implementation. This makes it incredibly easy to swap out the real database for an in-memory mock during unit testing.

Features:

• <strong>Abstract Interface</strong>: Depend on <code>AbstractTijuca</code> in your repositories/services to easily mock local storage in your tests.
<br/>
• <strong>Fast Concrete Implementation</strong>: Uses <code>MMKV</code> under the hood for high-performance synchronous reads and writes.
<br/>
• <strong>Built-in Mocking</strong>: Ships with <code>TijucaInMemoryMock</code> so you can write unit tests out of the box without needing external mocking libraries.
<br/>
• <strong>Type-Safe Serialization</strong>: Enforces custom serialization and deserialization closures right at the call site.
<br/>
• <strong>Strict Error Handling</strong>: Throws a predictable <code>NotExistingItemError</code> when attempting to read or remove a key that doesn"t exist.
</p>

<br />

<h3 id="installation">⬇️ Installation:</h3>

<p>Add the following to your <code>pubspec.yaml</code>:</p>

```yaml
dependencies:
  tijuca:
    git:
      url: "https://github.com/tupisoftwarehouse/Tijuca.git"
  mmkv: ^2.4.2
```

<br />

<h3 id="getting_started">🚀 Getting Started:</h3>

<p><strong>1. Define your Value Objects</strong><br/>
To use <code>tijuca</code>, your objects should know how to marshal (serialize) and unmarshal (deserialize) themselves.</p>

```dart
class MyItem {
  final String data;
  const MyItem(this.data);

  factory MyItem.fromMarshalledData(String marshalledData) {
    final unmarshalledData = jsonDecode(marshalledData);
    return MyItem(unmarshalledData["data"]);
  }

  String get marshalledData {
    return jsonEncode({"data": data});
  }
}
```

<p><br/><strong>2. Initialize the Database</strong><br/>
Inject the concrete implementation in your production code.</p>

```dart
import "package:mmkv/mmkv.dart";
import "package:tijuca/abstract_tijuca.dart";
import "package:tijuca/concrete_tijuca.dart";

// Ensure MMKV is initialized before using (usually in main.dart)
// await MMKV.initialize();

final MMKV mmkvInstance = MMKV.defaultMMKV();
final AbstractTijuca database = ConcreteTijuca(mmkvInstance);
```

<p><br/><strong>3. Store Data (<code>setItem</code>)</strong><br/>
Pass a closure that returns the serialized string.</p>

```dart
final myItem = MyItem("Hello World");

database.setItem<MyItem>(
  "my_item_key",
  () => myItem.marshalledData,
);
```

<p><br/><strong>4. Retrieve Data (<code>getItem</code>)</strong><br/>
Pass a closure that takes the serialized string and returns your strongly-typed object.</p>

```dart
try {
  final item = database.getItem<MyItem>(
    "my_item_key",
    (serializedData) => MyItem.fromMarshalledData(serializedData),
  );
  print(item.data); // Output: Hello World
} on NotExistingItemError catch (e) {
  print(e); // "Item with key \"my_item_key\" does not exist."
}
```

<p><br/><strong>5. Remove Data (<code>removeItem</code>)</strong></p>

```dart
try {
  database.removeItem("my_item_key");
} on NotExistingItemError catch (e) {
  // Handled if the item was already deleted or never existed
}
```

<br />

<h3 id="testing">🧪 Testing:</h3>

<p>The biggest advantage of <code>tijuca</code> is its built-in testability. When writing unit tests, simply inject the <code>TijucaInMemoryMock</code> instead of the concrete MMKV implementation.</p>

```dart
import "package:flutter_test/flutter_test.dart";
import "package:tijuca/abstract_tijuca.dart";
import "package:tijuca/tijuca_in_memory_mock.dart";

void main() {
  late AbstractTijuca testDatabase;

  setUp(() {
    // Uses a simple Map<String, String> under the hood!
    testDatabase = TijucaInMemoryMock();
  });

  test("It saves and retrieves an item successfully", () {
    testDatabase.setItem("test_key", () => "{\"data\": \"test\"}");

    final result = testDatabase.getItem("test_key", (data) => data);

    expect(result, "{\"data\": \"test\"}");
  });
}
```

<br />

<h3 id="contact">✉️ Contact:</h3>

**Creator's GitHub:**
<a href="https://github.com/samueldecarvalhodeveloper">https://github.com/samueldecarvalhodeveloper</a>
<br />
**Tupi's email:**
<a href="mailto:tupi.softwarehouse@gmail.com">tupi.softwarehouse@gmail.com</a>
