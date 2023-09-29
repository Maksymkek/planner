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
      type: fields[1] as ReminderType,
      title: fields[2] as String,
      time: fields[3] as DateTime,
      folderId: fields[4] as String,
      repeat: fields[7] as ReminderRepeat?,
      contacts: (fields[5] as List?)?.cast<String>(),
      action: fields[6] as String?,
      startDay: fields[8] == null ? 1 : fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderDataModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.folderId)
      ..writeByte(5)
      ..write(obj.contacts)
      ..writeByte(6)
      ..write(obj.action)
      ..writeByte(7)
      ..write(obj.repeat)
      ..writeByte(8)
      ..write(obj.startDay);
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
