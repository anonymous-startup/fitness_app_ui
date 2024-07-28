String capitalizeEachWord(String input) {
  return input.split(' ').map((word) {
    if (word.isEmpty) {
      return word;
    }
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

String extractNumberFromString(String input) {
  RegExp regExp = RegExp(r'\d+(\.\d+)?');
  Match? match = regExp.firstMatch(input);
  return match?.group(0) ?? '';
}
