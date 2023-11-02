import 'package:flutter_contacts/flutter_contacts.dart';

extension ContactListExtension on List<Contact> {
  Contact? getById(String searchedId) {
    for (final contact in this) {
      if (contact.id == searchedId) {
        return contact;
      }
    }
    return null;
  }
}
