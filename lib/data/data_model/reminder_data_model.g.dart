// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderDataModelAdapter extends TypeAdapter<ReminderDataModel> {
  @override
  final int typeId = 1;

  @override
  ReminderDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderDataModel(
      id: fields[0] as String,
      title: fields[1] as String,
      startDay: fields[7] == null ? 1 : fields[7] as int,
      time: fields[2] as DateTime,
      folderId: fields[3] as String,
      repeat: fields[6] as ReminderRepeat,
      contacts: (fields[4] as List?)?.cast<String>(),
      action: fields[5] as String?,
      description: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderDataModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.folderId)
      ..writeByte(4)
      ..write(obj.contacts)
      ..writeByte(5)
      ..write(obj.action)
      ..writeByte(6)
      ..write(obj.repeat)
      ..writeByte(7)
      ..write(obj.startDay)
      ..writeByte(8)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
