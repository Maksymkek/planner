import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:planner/presentation/common_widgets/contact_preview/contact_preview.dart';

class ContactListPreviewWidget extends StatelessWidget {
  ContactListPreviewWidget(
      {super.key, required this.contacts, this.size = 28}) {
    if (contacts.length > 3) {
      contacts = List.from(contacts)..removeRange(3, contacts.length);
    }
  }

  List<Contact> contacts;
  final double size;

  @override
  Widget build(BuildContext context) {
    var width = (size * 0.8);
    double offset = width * 2;
    return Stack(
      children: contacts.reversed.map((contact) {
        final widget = Padding(
            padding: EdgeInsets.only(left: offset),
            child: ContactPreviewWidget(contact: contact, size: size));
        offset -= width;
        return widget;
      }).toList(),
    );
  }
}
