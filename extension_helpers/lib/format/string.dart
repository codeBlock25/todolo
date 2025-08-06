part of 'format.dart';

enum SecureTextType { email, phone, plain }

enum TagPosition {
  front,
  back,
}

extension StringExt on String {
  String frontTag(String tag) {
    return "$tag$this";
  }

  int toIntFromString() {
    return int.tryParse(replaceAll(',', '')) ?? 0;
  }

  double toDoubleFromString() {
    return double.tryParse(replaceAll(',', '')) ?? 0;
  }

  String backTag(String tag) {
    return "$this$tag";
  }

  String conditionalTag(
      {required bool condition,
      required String tagText,
      required TagPosition position}) {
    if (condition) {
      return tag(tagText: tagText, position: position);
    } else {
      return this;
    }
  }

  String tag({required String tagText, required TagPosition position}) {
    switch (position) {
      case TagPosition.front:
        return frontTag(tagText);
      case TagPosition.back:
        return backTag(tagText);
    }
  }
}

String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2) return email; // Invalid email, return as is

  String username = parts[0];
  String domain = parts[1];

  // Mask username
  String maskedUsername;
  if (username.length <= 2) {
    maskedUsername = '${username[0]}*';
  } else {
    maskedUsername = username.substring(0, 3) + '*' * (username.length - 3);
  }

  // Mask domain name
  final domainParts = domain.split('.');
  if (domainParts.length < 2) return email; // Invalid domain, return as is

  String domainName = domainParts[0];
  String domainTld = domainParts.sublist(1).join('.');

  String maskedDomain;
  if (domainName.length <= 2) {
    maskedDomain = '${domainName[0]}*';
  } else {
    maskedDomain = domainName.substring(0, 2) + '*' * (domainName.length - 2);
  }

  return '$maskedUsername@$maskedDomain.$domainTld';
}

String maskPhone(String phone) {
  // Remove any non-digit characters from the phone number
  final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
  // Check if the phone number is valid
  if (digitsOnly.length < 10) {
    return phone; // Return the original phone number if it's too short
  }
  // Mask the first 6 digits and keep the last 4 digits
  final maskedDigits =
      '${digitsOnly.substring(0, 6)}****${digitsOnly.substring(digitsOnly.length - 4)}';
  // Format the masked phone number
  final formattedNumber = '($maskedDigits)';
  return formattedNumber;
}
