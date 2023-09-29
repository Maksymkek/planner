// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderTypeAdapter extends TypeAdapter<ReminderType> {
  @override
  final int typeId = 4;

  @override
  ReminderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReminderType.birthday;
      case 1:
        return ReminderType.meeting;
      case 2:
        return ReminderType.other;
      default:
        return ReminderType.birthday;
    }
  }

  @override
  void write(BinaryWriter writer, ReminderType obj) {
    switch (obj) {
      case ReminderType.birthday:
        writer.writeByte(0);
        break;
      case ReminderType.meeting:
        writer.writeByte(1);
        break;
      case ReminderType.other:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
