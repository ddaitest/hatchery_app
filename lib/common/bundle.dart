class Bundle {
  Map<String, dynamic> _map = {};

  _getValue(String key) {
    if (!_map.containsKey(key)) {
      throw Exception("$key not found!");
    }
    return _map[key];
  }

  putString(String key, String value) => _map[key] = value;

  putInt(String key, int value) => _map[key] = value;

  putBool(String key, bool value) => _map[key] = value;

  putList<V>(String key, List<V> value) => _map[key] = value;

  putMap<K, V>(String key, Map<K, V> value) => _map[key] = value;

  getString(String key) => _getValue(key) as String;

  getInt(String key) => _getValue(key) as int;

  getBool(String key) => _getValue(key) as bool;

  getList(String key) => _getValue(key) as List;

  getMap(String key) => _getValue(key) as Map;
}