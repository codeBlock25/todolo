part of 'utils.dart';


String? noEmojiValidator(String? value) {
  final emojiRegex = RegExp(
    r'[\u{1F600}-\u{1F64F}]|'     // Emoticons
    r'[\u{1F300}-\u{1F5FF}]|'     // Symbols & Pictographs
    r'[\u{1F680}-\u{1F6FF}]|'     // Transport & Map
    r'[\u{1F1E6}-\u{1F1FF}]|'     // Flags
    r'[\u{2600}-\u{26FF}]|'       // Misc symbols
    r'[\u{2700}-\u{27BF}]|'       // Dingbats
    r'[\u{1F900}-\u{1F9FF}]',     // Supplemental Symbols
    unicode: true,
  );

  if (value != null && emojiRegex.hasMatch(value)) {
    return 'Emojis are not allowed';
  }
  return null;
}