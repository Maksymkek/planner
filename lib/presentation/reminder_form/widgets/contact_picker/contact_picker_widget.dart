import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/presentation/common_widgets/contact_preview/contact_list_preview.dart';
import 'package:planner/presentation/reminder_form/model/reminder_form_model.dart';
import 'package:planner/presentation/reminder_form/show_picker.dart';
import 'package:planner/presentation/reminder_form/widgets/contact_picker/contact_list_widget.dart';
import 'package:planner/presentation/reminder_form/widgets/picker_container_widget.dart';
import 'package:provider/provider.dart';

class ContactPickerWidget extends StatefulWidget {
  const ContactPickerWidget({required super.key});
  static final GlobalKey<_ContactPickerWidgetState> globalKey = GlobalKey();
  @override
  State<ContactPickerWidget> createState() => _ContactPickerWidgetState();
}

class _ContactPickerWidgetState extends State<ContactPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return PickerContainerWidget(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Contacts',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          CupertinoButton(
            onPressed: () {
              showModalWindow(
                context,
                ContactListWidget(
                  selectedContacts:
                      Provider.of<ReminderFormModel>(context, listen: false)
                              .contacts ??
                          [],
                  key: ContactListWidget.globalKey,
                ),
                double.infinity,
              );
              //buildShowPicker(context);
            },
            child: buildContacts(),
          ),
        ],
      ),
    );
  }

  Widget buildContacts() {
    var contactsLength =
        Provider.of<ReminderFormModel>(context).contacts?.length ?? 0;
    final text =
        contactsLength == 0 ? 'no contacts' : contactsLength.toString();
    return Row(
      children: [
        ContactListPreviewWidget(
            contacts: Provider.of<ReminderFormModel>(context).contacts ?? []),
        (contactsLength == 0)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 7, right: 5),
                child: Container(
                  width: 1,
                  height: 22,
                  color: CupertinoColors.placeholderText,
                ),
              ),
        Text(text),
      ],
    );
  }
}
