import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        children: [
          buildPhoto(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.displayName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: contact.phones
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Text(
                                  e.number,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.link),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhoto() {
    if (contact.photo != null) {
      return ClipOval(
        child: Image.memory(
          contact.photo!,
          width: 32,
          height: 32,
        ),
      );
    }
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: const Icon(CupertinoIcons.person_fill),
    );
  }
}
