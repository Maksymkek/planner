import 'package:flutter_contacts/flutter_contacts.dart';

/// Refreshes device contact list.
abstract final class ContactManager {
  static List<Contact> _contacts = [];

  static List<Contact> get contacts => _contacts;

  static Future<void> refreshContacts() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      _contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    }
  }
}
