import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:planner/extensions/contact_list_extension.dart';
import 'package:planner/presentation/reminder_form/model/reminder_form_model.dart';
import 'package:planner/presentation/reminder_form/widgets/contact_picker/contact_picker_widget.dart';
import 'package:planner/presentation/reminder_form/widgets/contact_picker/contact_widget.dart';
import 'package:provider/provider.dart';

class ContactListWidget extends StatefulWidget {
  const ContactListWidget({
    required GlobalKey<_ContactListWidgetState> key,
    required this.selectedContacts,
  }) : super(key: key);

  final List<Contact> selectedContacts;
  static final GlobalKey<_ContactListWidgetState> globalKey = GlobalKey();

  @override
  State<ContactListWidget> createState() => _ContactListWidgetState();
}

class _ContactListWidgetState extends State<ContactListWidget> {
  List<Contact> contacts = [];
  late final List<Contact> selectedContacts;
  late final Future future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CupertinoActivityIndicator();
          }
          return Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CupertinoButton(
                    padding: EdgeInsets.only(right: 20, top: 15),
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      final formContext =
                          ContactPickerWidget.globalKey.currentContext;
                      if (formContext != null) {
                        Provider.of<ReminderFormModel>(formContext,
                                listen: false)
                            .onContactsSelected(selectedContacts);
                      }
                      Navigator.of(context).pop();
                    }),
              ),
              Expanded(
                child: ListView(
                    controller: ScrollController(initialScrollOffset: 0.1),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 0, left: 20, right: 20, bottom: 5),
                        child: Text(
                          'Contacts',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Column(
                        children: contacts.map((contact) {
                          return ContactWidget(
                            contact: contact,
                            isSelected: isSelected(contact),
                          );
                        }).toList(),
                      )
                    ]),
              ),
            ],
          );
        });
  }

  Future<void> onScreenLoad() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    }
  }

  bool isSelected(Contact searched) {
    return selectedContacts.getById(searched.id) != null ? true : false;
  }

  void removeContact(Contact searched) {
    selectedContacts.remove(selectedContacts.getById(searched.id));
  }

  @override
  void initState() {
    super.initState();
    future = onScreenLoad();
    selectedContacts = widget.selectedContacts;
  }
}
