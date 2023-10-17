import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactPreviewWidget extends StatelessWidget {
  const ContactPreviewWidget(
      {super.key, required this.contact, required this.size});

  final Contact contact;
  final double size;

  @override
  Widget build(BuildContext context) {
    return buildPhoto();
  }

  Widget buildPhoto() {
    if (contact.photo != null) {
      return ClipOval(
        child: Image.memory(
          contact.photo!,
          width: size,
          height: size,
        ),
      );
    }
    return Container(
      width: size + 0.5,
      height: size + 0.5,
      decoration: const BoxDecoration(
          color: CupertinoColors.lightBackgroundGray, shape: BoxShape.circle),
      child: Icon(
        CupertinoIcons.person_fill,
        size: size * 0.8,
        color: CupertinoColors.link,
      ),
    );
  }
}
