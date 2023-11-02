import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:planner/presentation/reminder_form/widgets/contact_picker/contact_list_widget.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget(
      {super.key, required this.contact, this.isSelected = false});

  final Contact contact;
  final bool isSelected;
  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          var listState = ContactListWidget.globalKey.currentState;
          if (isSelected) {
            listState?.selectedContacts.add(widget.contact);
          } else {
            listState?.removeContact(widget.contact);
          }
        });
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 3),
                child: Row(
                  children: [
                    buildPhoto(),
                    const SizedBox(width: 15),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.contact.displayName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 18),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: widget.contact.phones
                                .map((e) => Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        e.number,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: CupertinoColors.systemGrey),
                                      ),
                                    ))
                                .toList(),
                          ),
                        )
                      ],
                    )),
                    buildCheckMark()
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 55),
                child: Divider(
                  thickness: 1,
                  height: 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckMark() {
    if (!isSelected) {
      return const SizedBox();
    }
    return const Padding(
      padding: EdgeInsets.only(right: 3),
      child: Icon(
        CupertinoIcons.check_mark,
        size: 20,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  Widget buildPhoto() {
    if (widget.contact.photo != null) {
      return ClipOval(
        child: Image.memory(
          widget.contact.photo!,
          width: 40,
          height: 40,
        ),
      );
    }
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: CupertinoColors.lightBackgroundGray),
      child: const Icon(CupertinoIcons.person_fill),
    );
  }
}
