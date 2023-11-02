import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/presentation/common_widgets/app_bar.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';
import 'package:planner/presentation/reminder_form/model/reminder_form_model.dart';
import 'package:planner/presentation/reminder_form/widgets/contact_picker/contact_picker_widget.dart';
import 'package:planner/presentation/reminder_form/widgets/date_picker_widget.dart';
import 'package:planner/presentation/reminder_form/widgets/error_widget.dart';
import 'package:planner/presentation/reminder_form/widgets/repeat_picker_widget.dart';
import 'package:planner/presentation/reminder_form/widgets/text_input_widget.dart';
import 'package:provider/provider.dart';

class ReminderFormWidget extends StatefulWidget {
  const ReminderFormWidget({super.key, this.reminder, required this.folder});

  final Reminder? reminder;
  final Folder folder;

  @override
  State<ReminderFormWidget> createState() => _ReminderFormWidgetState();
}

class _ReminderFormWidgetState extends State<ReminderFormWidget> {
  late final ReminderFormModel model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: buildAppBar(
            context,
            withLeading: true,
            action: AppButtonWidget(
              text: 'Done',
              textStyle: const TextStyle(fontSize: 20),
              onPressed: () {
                Provider.of<ReminderFormModel>(context, listen: false)
                    .onDoneClicked()
                    .then((reminderCreated) {
                  if (reminderCreated) {
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ),
          backgroundColor: AppColors.light,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: FormListWidget(widget: widget),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    final time = DateTime.now();
    final reminder = widget.reminder ??
        Reminder(
            id: '-1', folderId: '', time: time, title: '', startDay: time.day);
    model = ReminderFormModel(reminder, widget.folder);
    model.onScreenLoad();
  }
}

class FormListWidget extends StatelessWidget {
  const FormListWidget({
    super.key,
    required this.widget,
  });

  final ReminderFormWidget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Builder(builder: (context) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          controller: ScrollController(initialScrollOffset: 0.1),
          children: [
            buildHeader(),
            buildTextInputs(context),
            const ReminderFormErrorWidget(),
            DatePickerWidget(
              name: 'Date',
              text: DateFormat(DateFormat.YEAR_MONTH_DAY)
                  .format(Provider.of<ReminderFormModel>(context).remindTime),
              minimumDate: DateTime.now(),
              onChanged: Provider.of<ReminderFormModel>(context, listen: false)
                  .onDatePicked,
              mode: CupertinoDatePickerMode.date,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            const Divider(
              height: 0.0,
              thickness: 1.0,
            ),
            DatePickerWidget(
              name: 'Time',
              text: buildTime(context),
              onChanged: Provider.of<ReminderFormModel>(context, listen: false)
                  .onTimePicked,
              mode: CupertinoDatePickerMode.time,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16.0)),
            ),
            const SizedBox(height: 10),
            const RepeatPickerWidget(),
            const SizedBox(height: 10),
            ContactPickerWidget(key: ContactPickerWidget.globalKey),
          ],
        );
      }),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 7),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            widget.reminder == null ? 'New reminder' : 'Edit reminder',
            maxLines: 1,
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget buildTextInputs(BuildContext context) {
    final model = Provider.of<ReminderFormModel>(context, listen: false);
    return Column(
      children: [
        TextInputWidget(
          placeholder: 'Title',
          text: model.title,
          onChanged: model.onTitleChanged,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        const Divider(
          height: 0.0,
          thickness: 1.0,
        ),
        TextInputWidget(
          placeholder: 'Description',
          text: model.description,
          onChanged: model.onDescriptionChanged,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
        const Divider(
          height: 0.0,
          thickness: 1.0,
        ),
        TextInputWidget(
          placeholder: 'Action',
          text: model.action,
          onChanged: model.onActionChanged,
          color: CupertinoColors.link,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
      ],
    );
  }

  String buildTime(BuildContext context) {
    return DateFormat(DateFormat.HOUR24_MINUTE)
        .format(Provider.of<ReminderFormModel>(context).remindTime);
  }
}
