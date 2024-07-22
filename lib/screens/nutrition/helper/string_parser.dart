Map<String, dynamic> convertStringToMap(String input) {
  Map<String, dynamic> parsedMap = {};
  String cleanedInput = input.replaceAll(RegExp(r'[{}]'), '');
  List<String> keyValuePairs = cleanedInput.split(',');

  for (String pair in keyValuePairs) {
    // Split each pair by the colon
    List<String> keyValue = pair.split(':');
    if (keyValue.length == 2) {
      String key = keyValue[0].trim();
      String value = keyValue[1].trim();

      // Remove quotes from the string values
      if (value.startsWith("'") && value.endsWith("'")) {
        value = value.substring(1, value.length - 1);
      }

      // Parse the value to its appropriate type
      if (value.contains('.') && double.tryParse(value) != null) {
        parsedMap[key] = double.parse(value);
      } else if (int.tryParse(value) != null) {
        parsedMap[key] = int.parse(value);
      } else {
        parsedMap[key] = value;
      }
    }
  }
  return parsedMap;
}
